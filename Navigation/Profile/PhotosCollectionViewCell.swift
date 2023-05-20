//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 20.05.2023.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {

    private enum Constants {
        // Generic layout constants
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 8.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0

        // profileImageView layout constants
        static let imageHeight: CGFloat = 180.0
    }
    
    // MARK: - Subviews

    private lazy var photosImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    private func setupSubviews() {
        contentView.addSubview(photosImageView)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
        ])
    }
    
    // MARK: - Public

    func setup(
        with photo: PhotoModel
    ) {
        photosImageView.image = UIImage(named: photo.image)
    }
}
