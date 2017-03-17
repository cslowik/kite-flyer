//
//  KiteRunner.swift
//  KiteFlyer
//

import Foundation
import Alamofire

class KiteRunner: NSObject {
    
    static let runner = KiteRunner()
    
    var saveFileURL: URL?
    var bookmarkURLSFileURL: URL?
    var saveDirectory: URL?
    
    var bookmarks: [[String:String]]? {
        get {
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: (bookmarkURLSFileURL?.path)!)
            guard savedData != nil else {
                return nil
            }
            return savedData as? [[String:String]]
        }
        set (newData) {
            NSKeyedArchiver.archiveRootObject(newData!, toFile: (bookmarkURLSFileURL?.path)!)
        }
    }
    
    var savedKites: [[String:URL]]? {
        get {
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: (saveFileURL?.path)!)
            guard savedData != nil else {
                return nil
            }
            return savedData as? [[String:URL]]
        }
        set (newData) {
            NSKeyedArchiver.archiveRootObject(newData!, toFile: (saveFileURL?.path)!)
        }
    }
    
    override init() {
        super.init()
        bootUP()
    }
    
    func bootUP() {
        saveDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        bookmarkURLSFileURL = saveDirectory?.appendingPathComponent("bookmarks")
    }

    func downloadKite(url: URL) -> URL {
        // download the file and return file location
        
        // get download destination
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("temp.zip")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        var checkedURL = url
        checkedURL.checkLink()
        
        return fileURL
    }
    
    
}







