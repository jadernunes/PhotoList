//
//  UIImageView+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-30.
//

import UIKit
import Photos

extension UIImageView {
    
    func addImage(_ asset: PHAsset?) {
        guard let asset = asset else {
            image = UIImage(named: "placeholder")
            return
        }
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: frame.size,
                                              contentMode: .default,
                                              options: nil,
                                              resultHandler: { [weak self] (image, info) in
                                                self?.image = image ?? UIImage(named: "placeholder")
        })
    }
}
