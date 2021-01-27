//
//  UIViewController+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-27.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(isHidden: Bool = true, prefersLargeTitles: Bool = false) {
        navigationController?.isNavigationBarHidden = isHidden
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.navigationBar.tintColor = isHidden ? .clear : .black
        navigationController?.view.backgroundColor = isHidden ? .clear : .white
        navigationController?.navigationBar.setValue(isHidden, forKey: "hidesShadow")
        navigationController?.navigationBar.setBackgroundImage(isHidden ? UIImage() : nil, for: .default)
        navigationController?.navigationBar.shadowImage = isHidden ? UIImage() : nil
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
    }
}
