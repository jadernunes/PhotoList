//
//  UIView+Extension.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import UIKit

extension UIView {
    
    @discardableResult func fillSuperview(padding: CGFloat = 0) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return self }
        
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: padding).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: padding).isActive = true
        heightAnchor.constraint(equalTo: superview.heightAnchor, constant: -(padding * 2)).isActive = true
        widthAnchor.constraint(equalTo: superview.widthAnchor, constant: -(padding * 2)).isActive = true
        
        return self
    }
    
    @discardableResult func centerInSuperview() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return self }
        
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        
        return self
    }
    
    /// Custom start loading
    func startLoading(_ color: UIColor = .white, _ style: UIActivityIndicatorView.Style = .large) {
        DispatchQueue.main.async { [weak self] in
            let loader = UIActivityIndicatorView(style: style)
            loader.color = color
            loader.tag = Constants().tagViewLoading
            
            self?.addSubview(loader)
            loader.centerInSuperview()
            
            loader.startAnimating()
            self?.bringSubviewToFront(loader)
        }
    }
    
    /// Custom stop loading
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.subviews.filter({ $0.tag == Constants().tagViewLoading }).first?.removeFromSuperview()
        }
    }
    
    @discardableResult func cornerRadius(value: CGFloat) -> UIView {
        layer.cornerRadius = value
        return self
    }
    
    @discardableResult func addShadow() -> UIView {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = .init(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        return self
    }
}
