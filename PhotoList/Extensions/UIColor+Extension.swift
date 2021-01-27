//
//  UIColor+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-27.
//

import UIKit

extension UIColor {
    
    // MARK: - Custom colors
    
    /// HEX: #474A51
    class func customDarkGray() -> UIColor {
        UIColor(named: "customDarkGray") ?? white
    }
    
    /// HEX: #EFEFF4
    class func customSystemGray() -> UIColor {
        UIColor(named: "customSystemGray") ?? white
    }
}
