//
//  Dynamic.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import Foundation

final class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    // MARK: - Attributes
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Life cycle
    
    init(_ v: T) {
        value = v
    }
    
    // MARK: - Custom methods
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func fire() {
        listener?(value)
    }
}
