//
//  ImageDetailViewController.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-30.
//

import UIKit
import Photos

final class ImageDetailViewController: BaseViewController {
    
    // MARK: - Attributes
    
    private var asset: PHAsset?
    
    // MARK: - Life cycle
    
    init(asset: PHAsset) {
        super.init()
        
        self.asset = asset
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createScrollView()
    }
    
    // MARK: - Custom methods
    
    private func setupUI() {
        view.backgroundColor = .customDarkGray()
    }
    
    private func createScrollView() {
        guard let asset = asset else { return }
        let scrollView = ImageZoomView(frame: view.frame, image: asset)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
