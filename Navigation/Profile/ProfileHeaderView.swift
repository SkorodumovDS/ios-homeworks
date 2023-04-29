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
       // button.frame = CGRect(x: 166, y: 264, width: 200, height: 50)
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
        
        //avatar.center = CGPoint(
         //   x: 64,
         //   y: 64)
        //avatar.frame = CGRect(x: 16, y: 16, width: 96, height: 96)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 48
        avatar.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        avatar.layer.borderWidth = 3
        
        return avatar
    }()
    
    private lazy var catTitle : UILabel = {
        let titleOfCat = UILabel()
        titleOfCat.translatesAutoresizingMaskIntoConstraints = false
        titleOfCat.text = "Hipster Cat"
        titleOfCat.font = UIFont(name: "Arial-Bold", size: 18)
        titleOfCat.textColor = UIColor.black
        
        return titleOfCat
        
    }()
    
    private lazy var catStatus : UITextView = {
        
        let statusCat = UITextView()
        statusCat.translatesAutoresizingMaskIntoConstraints = false
        statusCat.text = "Waiting for something..."
        statusCat.textColor = .gray
        statusCat.font = UIFont(name: "Regular", size: 14)
        statusCat.backgroundColor = backgroundColor
        return statusCat
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarCat)
        addSubview(catTitle)
        addSubview(catStatus)
        addSubview(actionButton)
        setupConstraints()
        //self.setupConstraints()
        
    }
    
    func setupConstraints() {
       
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            avatarCat.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarCat.widthAnchor.constraint(equalToConstant: 96),
            avatarCat.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarCat.heightAnchor.constraint(equalToConstant: 96),
            
            catTitle.leadingAnchor.constraint(
            equalTo: avatarCat.trailingAnchor, constant: 20),
            //catTitle.leadingAnchor.constraint(equalTo: avatarCat.trailingAnchor, constant: 16),
            //catTitle.widthAnchor.constraint(equalToConstant: 100),
            catTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            //catTitle.bottomAnchor.constraint(equalTo: catStatus.topAnchor, constant: -69),
            catTitle.heightAnchor.constraint(equalToConstant: 20),
            
            
            catStatus.leadingAnchor.constraint(
                equalTo: catTitle.leadingAnchor),
            //catStatus.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: 34),
            catStatus.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 74),
            catStatus.heightAnchor.constraint(equalToConstant: 20),
            catStatus.widthAnchor.constraint(equalToConstant: 200),
            
            /*actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
             */
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            actionButton.topAnchor.constraint(
                equalTo: avatarCat.bottomAnchor,
                constant: 16.0
            ),
           
            //actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50.0),
            //actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant:500) //actionButton.widthAnchor.constraint(equalToConstant: 393)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        NSLog(catStatus.text)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
}