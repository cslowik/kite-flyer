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
    var url:URLConvertible = "https://www.dropbox.com/sh/09nzxurf7qc6o6z/AADxhh4uT-utdygjjNsHLOZSa?dl=1"
    var kiteDocument: KiteDocument?
    var unzipDirectory: URL?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitPrototype))
        tap.numberOfTouchesRequired = 3
        tap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tap)
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("prototype.zip")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(url, to: destination).response { response in
            //print(response.response)
            
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
    
    func exitPrototype() {
        dismiss(animated: true, completion: nil)
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
