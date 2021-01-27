//
//  BaseViewController.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-27.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Life cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Custom methods
    
    private func setupUI() {
        view.backgroundColor = .white
    }
}
