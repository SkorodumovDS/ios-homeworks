//
//  LikedpostViewCell.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 26.10.2023.
//

import UIKit

class LikedpostViewCell: UITableViewCell {
    
    private lazy var mainImage: UIImageView = {
        
        let image  = UIImage(named: "Cat")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFit
        avatar.backgroundColor = .black
        return avatar
    }()
    
    private lazy var postTitle : UILabel = {
        let titlePost = UILabel()
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        titlePost.text = "Hipster Cat"
        titlePost.font = .systemFont(ofSize: 20,weight: .bold)
        titlePost.textColor = UIColor.black
        titlePost.numberOfLines = 2
        
        return titlePost
        
    }()
    
    private lazy var textPost : UILabel = {
        
        let postText = UILabel()
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.text = "Set your status..."
        postText.textColor = .systemGray
        postText.font = .systemFont(ofSize: 14)
        postText.numberOfLines = 0
        
        return postText
    }()
    
    private lazy var likesPost : UILabel = {
        
        let postText = UILabel()
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.text = "Likes"
        postText.textColor = .black
        postText.font = .systemFont(ofSize: 16)
        
        return postText
    }()
    
    private lazy var viewsPost : UILabel = {
        
        let postText = UILabel()
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.text = "Views"
        postText.textColor = .black
        postText.font = .systemFont(ofSize: 16)
        
        return postText
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
        addSubview(postTitle)
        addSubview(mainImage)
        addSubview(textPost)
        addSubview(likesPost)
        addSubview(viewsPost)
    }
    
    private func setupConstrains() {
        
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            postTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            postTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            postTitle.heightAnchor.constraint(equalToConstant: 25),
            
            mainImage.leadingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainImage.trailingAnchor.constraint(
            equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 0),
            mainImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            mainImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            textPost.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textPost.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textPost.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 16),
            
            likesPost.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            likesPost.topAnchor.constraint(equalTo: textPost.bottomAnchor, constant: 16),
            likesPost.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
           // likesPost.widthAnchor.constraint(equalToConstant: 50),
            
            viewsPost.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),

            viewsPost.topAnchor.constraint(
                equalTo: textPost.bottomAnchor,
                constant: 16.0
            ),
            viewsPost.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    func update(_ liked: LikedModel) {
        mainImage.image = UIImage(named: liked.image)
        postTitle.text = liked.author
        textPost.text = liked.description
        likesPost.text = "Likes: " + String(liked.likes)
        viewsPost.text = "Views: " + String(liked.views)
    }
}

