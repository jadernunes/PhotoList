//
//  HomeViewModel.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import Photos
import UIKit

protocol HomeViewModelProtocol {
    
    var dataDidChange: Dynamic<Int> { get }
    var isLoading: Dynamic<Bool> { get }
    
    func loadPhotos()
    func photo(_ index: Int) -> PHAsset?
    func countPhotos() -> Int
    func takePicture()
    func addImage(_ image: UIImage)
    func showImageDetail(index: Int)
    func deleteImage(index: Int)
}

final class HomeViewModel: NSObject, HomeViewModelProtocol {
    
     // MARK: - Attributes
    
    private var coordinator: HomeCoordinatorProtocol?
    private var photos = [PHAsset]() {
        didSet {
            dataDidChange.value = photos.count
        }
    }
    var dataDidChange = Dynamic<Int>(0)
    var isLoading = Dynamic<Bool>(false)
    
    // MARK: - Life cycle
    
    init(coordinator: HomeCoordinatorProtocol? = nil) {
        super.init()
        
        self.coordinator = coordinator
        setup()
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    // MARK: - Navigations
    
    func takePicture() {
        coordinator?.takePicture()
    }
    
    // MARK: - Services
    
    func loadPhotos() {
        isLoading.value = true
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .denied, .restricted:
            //TODO: Request authorization to library
            isLoading.value = false
            break
        default:
            PHPhotoLibrary.requestAuthorization { [weak self] authStatus in
                self?.isLoading.value = false
                
                guard authStatus == .authorized else {
                    //TODO: Show message to authorize
                    return
                }
                
                let allPhotosOptions = PHFetchOptions()
                allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
                
                let assets = PHAsset.fetchAssets(with: .image, options: allPhotosOptions)
                var images = [PHAsset]()
                
                assets.enumerateObjects { (photo, _, _) in
                    images.append(photo)
                }
                
                self?.photos = images
            }
        }
    }
    
    // MARK: - Custom methods
    
    private func setup() {
        PHPhotoLibrary.shared().register(self)
    }
    
    func photo(_ index: Int) -> PHAsset? {
        photos[safe: index]
    }
    
    func countPhotos() -> Int {
        photos.count
    }
    
    func addImage(_ image: UIImage) {
        // Add the asset to the photo library.
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let placeholder = creationRequest.placeholderForCreatedAsset ?? PHObjectPlaceholder()
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([placeholder] as NSArray)
        }, completionHandler: { success, error in
            //TODO: Work with error
        })
    }
    
    func deleteImage(index: Int) {
        guard let image = photos[safe: index] else { return }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(([image as Any] as NSArray))
        }, completionHandler: { success, error in
            //TODO: Work with error
        })
    }
    
    func showImageDetail(index: Int) {
        guard let photo = photos[safe: index] else { return }
        coordinator?.showImageDetail(photo)
    }
}

// MARK: PHPhotoLibraryChangeObserver

extension HomeViewModel: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        loadPhotos()
    }
}
