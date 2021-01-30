//
//  String+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-30.
//

import Foundation

extension String {
    
    public static func localizable(_ key: String) -> String {
        let textLocalised = NSLocalizedString(key, comment: "")
        return key == textLocalised ? "" : textLocalised
    }
}
