//
//  NSObject+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
}

extension ClassNameProtocol {
    
    static var className: String {
        return String(describing: self)
    }
}

extension NSObject: ClassNameProtocol {}
