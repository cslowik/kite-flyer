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
    let url:URLConvertible = "https://www.dropbox.com/sh/09nzxurf7qc6o6z/AADxhh4uT-utdygjjNsHLOZSa?dl=1"
    var kiteDocument: KiteDocument?
    var unzipDirectory: URL?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("heart.kite.zip")
            
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
                        fatalError("Could not create Kite Presentation View Controller")
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
                    print("Something went wrong")
                }
                
                
            }
        }
        
        
        
    }
    @IBAction func exitPrototype(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
