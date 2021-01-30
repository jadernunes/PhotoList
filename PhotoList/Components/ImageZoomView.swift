//
//  ImageZoomView.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-30.
//

import UIKit
import Photos

final class ImageZoomView: UIScrollView {
    
    // MARK: - Outlets
    
    private var imageView = UIImageView()
    
    // MARK: - Life cycle
    
    convenience init(frame: CGRect, image: PHAsset) {
        self.init(frame: frame)

        createImage(image)
        setupScrollView()
    }
    
    // MARK: - Custom methods
    
    private func createImage(_ image: PHAsset) {
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        imageView.addImage(image)
    }
    
    private func setupScrollView() {
        delegate = self
        minimumZoomScale = 0.1
        maximumZoomScale = 2.0
        isScrollEnabled = true
    }
}

// MARK: - Scroll View delegate

extension ImageZoomView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width = imageView.frame.size.width / scale
        
        let newCenter = convert(center, from: imageView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
