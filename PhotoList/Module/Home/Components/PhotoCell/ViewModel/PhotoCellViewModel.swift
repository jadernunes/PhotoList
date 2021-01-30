//
//  PhotoCellViewModel.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import Photos

protocol PhotoCellViewModelProtocol {
    var photo: Dynamic<PHAsset?> { get }
}

final class PhotoCellViewModel: PhotoCellViewModelProtocol {
    
    // MARK: - Attributes
    
    let photo = Dynamic<PHAsset?>(nil)
    
    // MARK: - Life cycle
    
    init(photo: PHAsset) {
        self.photo.value = photo
    }
}
