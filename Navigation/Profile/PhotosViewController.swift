//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 20.05.2023.
//

import UIKit

final class PhotosViewController: UIViewController {

    // MARK: - Data
        
        fileprivate lazy var photos: [PhotoModel] = PhotoModel.make()
        
        // MARK: - Subviews
        
        private let collectionView: UICollectionView = {
            let viewLayout = UICollectionViewFlowLayout()
            
            let collectionView = UICollectionView(
                frame: .zero,
                collectionViewLayout: viewLayout
            )
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .systemBackground
            
            collectionView.register(
                PhotosCollectionViewCell.self,
                forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
            )
            
            return collectionView
        }()
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupView()
            setupSubviews()
            setupLayouts()
        }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
        
        // MARK: - Private
        
        private func setupView() {
            view.backgroundColor = .systemBackground
            title = "Photo Gallery"
            navigationController?.navigationBar.isHidden = false
        }

        private func setupSubviews() {
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            view.addSubview(collectionView)
            
            collectionView.dataSource = self
            collectionView.delegate = self
        }

        private func setupLayouts() {
            let safeAreaGuide = view.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
            ])
        }
        
        private enum LayoutConstant {
            static let spacing: CGFloat = 8.0
            static let itemHeight: CGFloat = 180.0
        }
    }

    extension PhotosViewController: UICollectionViewDataSource {
        
        func collectionView(
            _ collectionView: UICollectionView,
            numberOfItemsInSection section: Int
        ) -> Int {
            photos.count
        }

        func collectionView(
            _ collectionView: UICollectionView,
            cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PhotosCollectionViewCell.identifier,
                for: indexPath) as! PhotosCollectionViewCell
            
            let photo = photos[indexPath.row]
            cell.setup(with: photo)
            
            return cell
        }
    }

    extension PhotosViewController: UICollectionViewDelegateFlowLayout {
        
        private func itemWidth(
            for width: CGFloat,
            spacing: CGFloat
        ) -> CGFloat {
            let itemsInRow: CGFloat = 3
            
            let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow
            
            return floor(finalWidth)
        }
        
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            let width = itemWidth(
                for: view.frame.width,
                spacing: LayoutConstant.spacing
            )
            
            return CGSize(width: width, height: LayoutConstant.itemHeight)
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAt section: Int
        ) -> UIEdgeInsets {
            UIEdgeInsets(
                top: LayoutConstant.spacing,
                left: LayoutConstant.spacing,
                bottom: LayoutConstant.spacing,
                right: LayoutConstant.spacing
            )
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
            LayoutConstant.spacing
        }

        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumInteritemSpacingForSectionAt section: Int
        ) -> CGFloat {
            LayoutConstant.spacing
        }
}
