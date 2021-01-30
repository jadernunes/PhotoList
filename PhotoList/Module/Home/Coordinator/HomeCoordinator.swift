//
//  HomeCoordinator.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import UIKit
import Photos

protocol HomeCoordinatorProtocol {
    func takePicture()
    func showImageDetail(_ asset: PHAsset)
}

final class HomeCoordinator: NSObject, Coordinator {
    
    // MARK: - Attributes
    
    private weak var navigation: UINavigationController?
    private var viewController: HomeViewController?
    
    // MARK: - Life cycle
    
    init(presenter: UINavigationController) {
        navigation = presenter
    }
    
    // MARK: - Navigations
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        viewController = HomeViewController(viewModel: viewModel)
        navigation?.viewControllers = [viewController ?? HomeViewController(viewModel: HomeViewModel())]
    }
}

// MARK: - Home coordinator

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func takePicture() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = viewController
        navigation?.present(vc, animated: true)
    }
    
    func showImageDetail(_ asset: PHAsset) {
        let imageDetail = ImageDetailViewController(asset: asset)
        navigation?.present(imageDetail, animated: true)
    }
}
