//
//  ViewController.swift
//  Device-iOSKiteKitExample
//

import UIKit

import AVFoundation
import JavaScriptCore
import MobileCoreServices
import KiteKit

class PlayerVC: UIViewController {
    
    var kiteViewController: KitePresentationViewController?
    let url = "https://www.dropbox.com/sh/h3fprayk950vczd/AACCWOuwHge44pvP4gl62PWca?dl=0"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Get a URL to the embedded Kite document 'Heart.kite'
        //
        guard let documentURL = Bundle.main.url(forResource: "heart", withExtension: "kite") else {
            fatalError("Bundled kite document not found!")
        }
        
        // Create a KiteDocument object to load the file
        //
        let kiteDocument = KiteDocument(fileURL: documentURL)
        
        // Create a KitePresentationViewController to present the view
        //
        guard let kitePresentationViewController = KitePresentationViewController(kiteDocument: kiteDocument) else {
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
    @IBAction func exitPrototype(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
