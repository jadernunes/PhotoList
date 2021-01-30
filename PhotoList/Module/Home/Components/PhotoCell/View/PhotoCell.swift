//
//  PhotoCell.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-29.
//

import UIKit
import Photos

final class PhotoCell: UICollectionViewCell {
    
    // MARK: - Attributes
    
    private var viewModel: PhotoCellViewModelProtocol?

    // MARK: - Elements

    private(set) lazy var viewContent = UIView()
    private(set) lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Custom methods

    private func setupUI() {
        createViewContent()
        createImageView()
    }
    
    func configure(viewModel: PhotoCellViewModelProtocol) {
        self.viewModel = viewModel
        bindImageView()
    }
}

// MARK: - Binds

extension PhotoCell {
    
    func bindImageView() {
        viewModel?.photo.bindAndFire { [weak self] photo in
            self?.imageView.addImage(photo)
        }
    }
}
