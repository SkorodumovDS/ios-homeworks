//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 20.05.2023.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    
    
    // MARK: - Data
    
    fileprivate lazy var photos: [PhotoModel] = PhotoModel.make()
    //var imageFacade = ImagePublisherFacade()
    var imageProcessor = ImageProcessor()
    var array = [UIImage]()
    var index = 0
    var photoarray = [UIImage]()
    var coordimator : ProfileFlowCoordinator?
    let clock = ContinuousClock()
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
        
        /*
        imageFacade.subscribe(self)
        imageFacade.addImagesWithTimer(time: 1, repeat: 20, userImages: photoarray)
         */
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        //imageFacade.removeSubscription(for: self)
    }
    
    // MARK: - Private
    
    private func setupView() {
        
        photoarray.removeAll()
        for photo in photos {
            photoarray.append(UIImage(named: photo.image)!)
        }
         
        view.backgroundColor = .systemBackground
        title = "Photo Gallery".localized()
        navigationController?.navigationBar.isHidden = false
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(sourceImages: photoarray, filter: .colorInvert, qos:.userInteractive, completion: { [self] photoArrayImp in
                        self.array.removeAll()
                        for photo in  photoArrayImp {
                            array.append(UIImage(cgImage: photo!))
                        }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        let end = DispatchTime.now()// <<<<<<<<<<   end time
                        let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                            let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests

                        print("Filter process time is \(timeInterval.formatted(.number))")
                    }
                    })
       
       
        //imageFacade.subscribe(self)
        
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
        array.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath) as! PhotosCollectionViewCell
        
        let new = array[indexPath.row]
        cell.setup(with: new)
        
    
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

extension  PhotosViewController {
    
    func receive(images: [UIImage]) {
        while index < images.count {
            let image = images[index]
            array.append(image)
            index += 1
        }
        collectionView.reloadData()
    }
}
