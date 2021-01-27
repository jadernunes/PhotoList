//
//  HomeViewModel.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func openGallery()
}

final class HomeViewModel: HomeViewModelProtocol {
    
     // MARK: - Attributes
    
    private let coordinator: HomeCoordinatorProtocol?
    
    // MARK: - Life cycle
    
    init(coordinator: HomeCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    // MARK: - Navigations
    
    func openGallery() {
        coordinator?.openGallery()
    }
}
