//
//  HomeViewModel.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import Photos

protocol HomeViewModelProtocol {
    
    var dataDidChange: Dynamic<()?> { get }
    var isLoading: Dynamic<Bool> { get }
    
    func loadPhotos()
    func photo(_ index: Int) -> PHAsset?
    func countPhotos() -> Int
}

final class HomeViewModel: NSObject, HomeViewModelProtocol {
    
     // MARK: - Attributes
    
    private var coordinator: HomeCoordinatorProtocol?
    private var photos = [PHAsset]() {
        didSet {
            dataDidChange.fire()
        }
    }
    var dataDidChange = Dynamic<()?>(nil)
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
}

// MARK: PHPhotoLibraryChangeObserver

extension HomeViewModel: PHPhotoLibraryChangeObserver {
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        loadPhotos()
    }
}
