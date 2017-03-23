//
//  KiteRunner.swift
//  KiteFlyer
//

import Foundation

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
        saveFileURL = saveDirectory?.appendingPathComponent("saves")
    }
}
