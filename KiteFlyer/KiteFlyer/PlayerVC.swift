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

class PlayerVC: UIViewController {
    
    var kiteViewController: KitePresentationViewController?
    let url:URLConvertible = "https://www.dropbox.com/sh/h3fprayk950vczd/AACCWOuwHge44pvP4gl62PWca?dl=0"
    var kiteDocument: KiteDocument?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let location = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)

        
        Alamofire.download(url, to: location).response { response in
            print(response)
            
            if response.error == nil {
                self.kiteDocument = KiteDocument(fileURL: response.destinationURL!)
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
        }
        
        
        
    }
    @IBAction func exitPrototype(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
