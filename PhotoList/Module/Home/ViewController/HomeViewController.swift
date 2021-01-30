//
//  HomeViewController.swift
//  PhotoList
//
//  Created by Jader Nunes on 2021-01-25.
//

import UIKit
import Photos

private enum ItemsPerPage: Int {
    case portrait = 3
}

final class HomeViewController: BaseViewController {
    
    // MARK: - Attributes
    
    private(set) var viewModel: HomeViewModelProtocol?
    
    // MARK: - Outlets
    
    private(set) lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.contentInset = .init(top: 16, left: 8, bottom: 16, right: 8)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.className)
        return collectionView
    }()
    private(set) lazy var buttonAdd = UIBarButtonItem(barButtonSystemItem: .add,
                                                      target: self,
                                                      action: #selector(buttonAddPressed))
    
    // MARK: - Life cycle
    
    init(viewModel: HomeViewModelProtocol) {
        super.init()
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createElements()
        bindUI()
        viewModel?.loadPhotos()
    }
    
    // MARK: - Custom methods
    
    private func setupUI() {
        view.backgroundColor = .customDarkGray()
        title = .localizable("titleHome")
        navigationItem.rightBarButtonItems = [buttonAdd]
        configureNavigationBar(isHidden: false, prefersLargeTitles: true)
    }
    
    private func bindUI() {
        bindData()
        bindLoader()
    }
    
    private func createElements() {
        addCollectionView()
    }
    
    private func sizeGalley() -> CGSize {
        switch UIDevice.current.orientation {
        case .faceDown, .faceUp, .portrait, .portraitUpsideDown:
            let dimension = view.frame.width / 3 - CGFloat((ItemsPerPage.portrait.rawValue * 4))
            return .init(width: dimension, height: dimension)
        default:
            return .zero
        }
    }
    
    // MARK: - Actions
    
    @objc private func buttonAddPressed() {
        viewModel?.takePicture()
    }
}

// MARK: - Binds

private extension HomeViewController {
    
    func bindData() {
        viewModel?.dataDidChange.bind { [weak self] count in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.collectionView.scrollToItem(at: IndexPath(row: count - 1, section: 0),
                                                  at: .bottom, animated: true)
            }
        }
    }
    
    func bindLoader() {
        viewModel?.isLoading.bind { [weak self] isLoading in
            isLoading
                ? self?.collectionView.startLoading()
                : self?.collectionView.stopLoading()
        }
    }
}

// MARK: - CollectionView datasource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.countPhotos() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.className, for: indexPath) as? PhotoCell,
            let data = viewModel?.photo(indexPath.row)
        else { return UICollectionViewCell() }
        
        cell.configure(viewModel: PhotoCellViewModel(photo: data))
        return cell
    }
}

// MARK: - Collection view flow delegate

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeGalley()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.showImageDetail(index: indexPath.row)
    }
}

// MARK: - ImagePicker delegate

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            //TODO: Work with error
            return
        }
        
        viewModel?.addImage(image)
    }
}
