//
//  HomeViewController+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

// MARK: - Constraints

import UIKit

extension HomeViewController {
    
    func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
}
