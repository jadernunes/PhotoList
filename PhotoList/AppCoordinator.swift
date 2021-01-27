//
//  AppCoordinator.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-26.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Attributes
    
    static var window: UIWindow? = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.window
    }()
    
    // MARK: - Navigations
    
    static func start() {
        let navigation = UINavigationController()
        let coordinator = HomeCoordinator(presenter: navigation)
        coordinator.start()
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
