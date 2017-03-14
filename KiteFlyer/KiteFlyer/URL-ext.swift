//
//  URL-ext.swift
//  KiteFlyer
//

import Foundation

extension URL {
    
    mutating func checkLink() {
        // utility function to check a given URL for special cases
    
        var newLink = self.absoluteString
        
        // check for dropbox. dropbox links should end with 1
        if newLink.lowercased().range(of:"dropbox.com") != nil {
            newLink = newLink.substring(to: newLink.index(before: newLink.endIndex)) + "1"
        }
        
        guard let link = URL(string: newLink) else { return }
        self = link
        
    }
}
