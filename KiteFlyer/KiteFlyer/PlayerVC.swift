//
//  ViewController.swift
//  Device-iOSKiteKitExample
//

import UIKit

import AVFoundation
import JavaScriptCore
import MobileCoreServices
import KiteKit
import Alamofire
import Zip

class PlayerVC: UIViewController {
    
    var kiteViewController: KitePresentationViewController?
    var url = "https://www.dropbox.com/sh/09nzxurf7qc6o6z/AADxhh4uT-utdygjjNsHLOZSa?dl=1"
    var name = ""
    var filename = "temp"
    var kiteDocument: KiteDocument?
    var unzipDirectory: URL?
    let runner = KiteRunner.runner
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMenu))
        tap.numberOfTouchesRequired = 3
        tap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tap)
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("\(self.filename).zip")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: destination).response { response in
            if response.error == nil {
                
                do {
                    let filePath = response.destinationURL!
                    self.unzipDirectory = try Zip.quickUnzipFile(filePath) // Unzip
                    
                    self.kiteDocument = KiteDocument(fileURL: self.unzipDirectory!)
                    // Create a KitePresentationViewController to present the view
                    //
                    
                    guard let kitePresentationViewController = KitePresentationViewController(kiteDocument: self.kiteDocument!) else {
                        self.unableToLoad()
                        return
                    }
                    
                    self.runner.bookmarks.append(["name":self.name, "url":self.url])
                    // Hold on to a strong reference to the view controller
                    //
                    self.kiteViewController = kitePresentationViewController
                    
                    // Add the KitePresentationView to the view hierarchy
                    //
                    self.view.addSubview(kitePresentationViewController.view)
                    
                    // Start the document playback
                    //
                    self.kiteViewController?.startPresenting()
                }
                catch {
                    self.unableToLoad()
                }
                
                
            }
            
        }
    }
    
    func showMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let exitAction = UIAlertAction(title: "Exit Prototype", style: .destructive) { _ in self.exitPrototype() }
        let restartAction = UIAlertAction(title: "Restart Prototype", style: .default) { _ in self.startOver() }
        alertController.addAction(cancelAction)
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func exitPrototype() {
        dismiss(animated: true, completion: nil)
    }
    
    func startOver() {
        kiteViewController?.startPresenting()
    }
    
    func unableToLoad() {
        let alertController = UIAlertController(title: "Error", message: "Unable to fly that kite. You sure that link is correct?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Darn!", style: .default) { _ in
            self.exitPrototype()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
