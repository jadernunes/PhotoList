//
//  PhotoCell+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import UIKit

// MARK: - Create elements

extension PhotoCell {
    
    func createViewContent() {
        addSubview(viewContent)
        viewContent.backgroundColor = .lightGray
        viewContent
            .cornerRadius(value: 8)
            .addShadow()
            .fillSuperview(padding: 4)
            .addSubview(imageView)
    }
    
    func createImageView() {
        imageView
            .cornerRadius(value: 8)
            .fillSuperview()
            .layer.masksToBounds = true
    }
}
