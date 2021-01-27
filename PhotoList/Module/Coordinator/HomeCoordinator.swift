//
//  HomeCoordinator.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import UIKit

protocol HomeCoordinatorProtocol {
    func openGallery()
}

final class HomeCoordinator: Coordinator {
    
    // MARK: - Attributes
    
    private weak var navigation: UINavigationController?
    
    // MARK: - Life cycle
    
    init(presenter: UINavigationController) {
        navigation = presenter
    }
    
    // MARK: - Navigations
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigation?.viewControllers = [viewController]
    }
}

// MARK: - Home coordinator

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func openGallery() {
        //TODO: Open gallery
    }
}
