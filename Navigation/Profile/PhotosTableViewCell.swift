//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 19.05.2023.
//


import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var firstImage: UIImageView = {
        
        let image  = UIImage(named: "1")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 6
        avatar.clipsToBounds = true
        return avatar
    }()
    
    private lazy var secondImage: UIImageView = {
        
        let image  = UIImage(named: "2")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 6
        avatar.clipsToBounds = true
        return avatar
    }()
    
    private lazy var thirdImage: UIImageView = {
        
        let image  = UIImage(named: "3")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 6
        avatar.clipsToBounds = true
        return avatar
    }()
    
    private lazy var fourthImage: UIImageView = {
        
        let image  = UIImage(named: "4")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.layer.cornerRadius = 6
        avatar.clipsToBounds = true
        return avatar
    }()
    

    private lazy var nextButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let arrowImage = UIImage(systemName: "arrow.right")
        let arrow = UIImageView(image: arrowImage)
        button.setImage(arrowImage, for: UIControl.State())
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var PhotosLabel : UILabel = {
        let titlePost = UILabel()
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        titlePost.text = "Photos".localized()
        titlePost.font = .systemFont(ofSize: 24,weight: .bold)
        titlePost.textColor = UIColor.black
        
        return titlePost
        
    }()
    
    private lazy var stack: UIStackView  = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )
        addsubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubviews(){
        addSubview(PhotosLabel)
        addSubview(nextButton)
        stack.addArrangedSubview(firstImage)
        stack.addArrangedSubview(secondImage)
        stack.addArrangedSubview(thirdImage)
        stack.addArrangedSubview(fourthImage)
        addSubview(stack)
        
    }
    
    private func setupConstrains() {
        
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
           
            self.heightAnchor.constraint(equalToConstant: 150),
            
            PhotosLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            PhotosLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            PhotosLabel.widthAnchor.constraint(equalToConstant: 100),
            PhotosLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nextButton.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            nextButton.centerYAnchor.constraint(equalTo: PhotosLabel.centerYAnchor, constant: 0),
            nextButton.heightAnchor.constraint(equalToConstant: 25),
            nextButton.widthAnchor.constraint(equalToConstant: 25),
            
            stack.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            stack.topAnchor.constraint(equalTo: PhotosLabel.bottomAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
            
             ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
    }
    
}

