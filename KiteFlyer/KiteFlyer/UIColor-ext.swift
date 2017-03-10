//
//  UIColor-ext.swift
//  KiteFlyer
//

import UIKit

extension UIColor {
    
    private struct Cache {
        
        // The standards
        static let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        static let black = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        // colors
        static let greenBG = UIColor(red:0.020, green:0.831, blue:0.843, alpha:1.000)
        static let greenNavBG = UIColor(red:0.192, green:0.890, blue:0.906, alpha:1.000)
        
        // overlays
        static let tableCellOverlay = UIColor(red:0.161, green:0.176, blue:0.192, alpha:0.050)
    }
    
    public class var white: UIColor { return Cache.white }
    public class var black: UIColor { return Cache.black }
    public class var greenBG: UIColor { return Cache.greenBG }
    public class var greenNavBG: UIColor { return Cache.greenNavBG }
    public class var tableCellOverlan: UIColor { return Cache.tableCellOverlay }
    
}
