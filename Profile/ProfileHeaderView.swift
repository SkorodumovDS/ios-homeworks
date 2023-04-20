//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 17.04.2023.
//
import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 166, y: 264, width: 200, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = CGColor(srgbRed: 0, green: 191, blue: 255, alpha: 1)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarCat: UIImageView = {
        
        let image  = UIImage(named: "Cat")
        let avatar =  UIImageView(image: image)
        
        avatar.center = CGPoint(
            x: 64,
            y: 64)
        avatar.frame = CGRect(x: 16, y: 16, width: 96, height: 96)
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 48
        avatar.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        avatar.layer.borderWidth = 3
        
        return avatar
    }()
    
    private lazy var catTitle : UILabel = {
        let titleOfCat = UILabel(frame: CGRect(x: 128, y: 27, width: 150, height: 25))
        titleOfCat.text = "Hipster Cat"
        titleOfCat.font = UIFont(name: "Arial-Bold", size: 18)
        titleOfCat.textColor = UIColor.black
        
        return titleOfCat
        
    }()
    
    private lazy var catStatus : UITextView = {
        
        let statusCat = UITextView(frame: CGRect(x: 128, y: 94, width:200 , height: 18))
        statusCat.text = "Waiting for something..."
        statusCat.textColor = .gray
        statusCat.font = UIFont(name: "Regular", size: 14)
        statusCat.backgroundColor = backgroundColor
        return statusCat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(avatarCat)
        addSubview(catTitle)
        addSubview(catStatus)
        addSubview(actionButton)
        
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            avatarCat.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            avatarCat.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            
            catTitle.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            catTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            
            catStatus.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor),
            //catStatus.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 34),
            catStatus.bottomAnchor.constraint(equalTo: catTitle.topAnchor, constant: 69),
            
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            actionButton.topAnchor.constraint(
                equalTo: avatarCat.bottomAnchor,
                constant: 16.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),
            //actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*NSLayoutConstraint.activate([
     actionButton.leadingAnchor.constraint(
     equalTo: safeAreaLayoutGuide.leadingAnchor,
     constant: 20.0
     ),
     actionButton.trailingAnchor.constraint(
     equalTo: safeAreaLayoutGuide.trailingAnchor,
     constant: -20.0
     ),
     actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
     actionButton.heightAnchor.constraint(equalToConstant: 44.0)
     ])
     */
    //actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    
    
    @objc func buttonPressed(_ sender: UIButton) {
        NSLog(catStatus.text)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

//avatarCat.leadingAnchor.constraint(equalTo: view?.leadingAnchor, constant: 16)
