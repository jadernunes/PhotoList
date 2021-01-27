//
//  HomeViewController.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-25.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: - Attributes
    
    private(set) var viewModel: HomeViewModelProtocol?
    
    // MARK: - Life cycle
    
    init(viewModel: HomeViewModelProtocol) {
        super.init()
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
