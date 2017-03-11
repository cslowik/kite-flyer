//
//  KiteRunner.swift
//  KiteFlyer
//

import Foundation

class KiteRunner: NSObject {
    
    static let runner = KiteRunner()
    
    var bookmarkFileURL: URL?
    var bookmarkURLSFileURL: URL?
    var saveDirectory: URL?
    
    var bookmarks: [[String:String]]? {
        get {
            let savedData = NSKeyedUnarchiver.unarchiveObject(withFile: (bookmarkFileURL?.path)!)
            guard savedData != nil else {
                return nil
            }
            return savedData as? [[String:String]]
        }
        set (newData) {
            NSKeyedArchiver.archiveRootObject(newData!, toFile: (bookmarkFileURL?.path)!)
        }
    }
    
    override init() {
        super.init()
        bootUP()
    }
    
    func bootUP() {
        saveDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        bookmarkFileURL = saveDirectory?.appendingPathComponent("bookmarks")
    }
}
