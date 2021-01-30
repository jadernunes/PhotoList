//
//  Collection+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
