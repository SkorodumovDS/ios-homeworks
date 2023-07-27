//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 17.04.2023.
//
import UIKit

class ProfileHeaderView: UIView {
    
    var currentUser : User?
    
    private lazy var actionButton: UIButton = {
        let buttonLog = CustomButton(title: "Set status", titleColor: .white, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.buttonPressed()
                    }
        buttonLog.layer.cornerRadius = 4
        buttonLog.layer.shadowOffset = CGSize(width: 4, height: 4)
        buttonLog.layer.shadowRadius = CGFloat(4)
        buttonLog.layer.shadowColor = UIColor.black.cgColor
        buttonLog.layer.shadowOpacity = 0.7
        return buttonLog
    }()
    
    private lazy var avatarCat: UIImageView = {
        
        let image  = UIImage(named: "Cat")
        
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 48
        avatar.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        avatar.layer.borderWidth = 3
        
        
        let tapAvatar = UITapGestureRecognizer(
                   target: self,
                   action: #selector(tapAvatar)
               )
        avatar.isUserInteractionEnabled = true
        tapAvatar.numberOfTapsRequired = 1
        avatar.addGestureRecognizer(tapAvatar)
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
    
    private lazy var catStatus : UILabel = {
        
        let statusCat = UILabel()
        statusCat.translatesAutoresizingMaskIntoConstraints = false
        statusCat.text = "Waiting for something..."
        
        statusCat.textColor = .gray
        statusCat.font = UIFont(name: "Regular", size: 14)
       
        return statusCat
    }()
    
    private lazy var newCatStatus : UITextField = {
        
        let statusCat = UITextField()
        statusCat.translatesAutoresizingMaskIntoConstraints = false
        statusCat.placeholder = "Set your status..."
        statusCat.textColor = .gray
        statusCat.font = UIFont(name: "Regular", size: 14)
        statusCat.backgroundColor = .white
        
        statusCat.clipsToBounds = true
        statusCat.layer.cornerRadius = 10
        statusCat.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        statusCat.layer.borderWidth = 1
        return statusCat
    }()
    
    private lazy var tapButton: UIButton = {
        let button = UIButton()
    
        button.translatesAutoresizingMaskIntoConstraints = false
        let exitImage = UIImage(systemName: "xmark")
        let exit = UIImageView(image: exitImage)
        button.setImage(exitImage, for: UIControl.State())
        button.alpha = 0
        button.addTarget(self, action: #selector(exitButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bigAvatarCat: UIImageView = {
        
        let image  = UIImage(named: "Cat")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.contentMode = .scaleAspectFill
        avatar.layer.opacity = 0
        avatar.clipsToBounds = false
        
        return avatar
        
    }()
    
    let dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.alpha = 0.8
        dimmingView.backgroundColor = .gray
        dimmingView.frame = UIScreen.main.bounds
        
        return dimmingView
    }()
       
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
        translatesAutoresizingMaskIntoConstraints = false
    
        addSubview(avatarCat)
        addSubview(catTitle)
        addSubview(catStatus)
        addSubview(newCatStatus)
        addSubview(actionButton)
        addSubview(tapButton)
        addSubview(bigAvatarCat)
        setupConstraints()
        //imageTapped()
    }
    
    func initializeUser(user: User?) {
        currentUser = user
        catStatus.text = currentUser?.status
        catTitle.text = currentUser?.fullName
        avatarCat.image = currentUser?.avatar
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
            catTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            catTitle.heightAnchor.constraint(equalToConstant: 20),
                  
            catStatus.leadingAnchor.constraint(
                equalTo: catTitle.leadingAnchor),
            catStatus.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 64),
            catStatus.heightAnchor.constraint(equalToConstant: 20),
            catStatus.widthAnchor.constraint(equalToConstant: 200),
            
            newCatStatus.leadingAnchor.constraint(
                equalTo: catStatus.leadingAnchor),
            newCatStatus.topAnchor.constraint(equalTo: catStatus.bottomAnchor, constant: 5),
            newCatStatus.heightAnchor.constraint(equalToConstant: 35),
            newCatStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
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
           
            actionButton.heightAnchor.constraint(equalToConstant: 50.0),
            actionButton.widthAnchor.constraint(equalToConstant: 361),
                    
            bigAvatarCat.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            bigAvatarCat.widthAnchor.constraint(equalToConstant: 96),
            bigAvatarCat.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            bigAvatarCat.heightAnchor.constraint(equalToConstant: 96)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateSize(width: CGFloat, height: CGFloat) {
        CATransaction.begin()
        let sizeAnimation = CABasicAnimation(keyPath: "bounds.size")
        sizeAnimation.duration = 2
        sizeAnimation.isRemovedOnCompletion = false
        sizeAnimation.toValue = CGSize(width: width, height: width)
        bigAvatarCat.layer.add(sizeAnimation, forKey: "bounds.size")
        bigAvatarCat.layer.bounds.size = CGSize(width: width, height: width)
        CATransaction.commit()
    }
    
    @objc func tapAvatar(_ sender: UITapGestureRecognizer) {
        let centerOrigin = superview!.superview!.superview!.center
        bigAvatarCat.translatesAutoresizingMaskIntoConstraints = true
        tapButton.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.5) {
           
            addedSub()

            self.bigAvatarCat.center = CGPoint(x: centerOrigin.x, y: centerOrigin.y - 20)
            self.animateSize(width: self.superview!.frame.width,
                             height: self.superview!.frame.width)
            
            self.tapButton.center = CGPoint(x: self.bigAvatarCat.bounds.width - 15, y: centerOrigin.y - self.bigAvatarCat.bounds.width / 2)

            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0,
                           options: .curveEaseInOut) {
                
                self.dimmingView.layer.opacity = 0.8
                self.bigAvatarCat.layer.cornerRadius = 10
                self.bigAvatarCat.layer.opacity = 1

            }
            
            UIView.animate(withDuration: 0.3, delay: 0.5) {
                self.tapButton.layer.opacity = 1
                self.tapButton.alpha = 1
            }
        }
        
        func addedSub() {
            addSubview(dimmingView)
            addSubview(bigAvatarCat)
            addSubview(tapButton)
        }
    }
        
    @objc func buttonPressed() {
        catStatus.text = newCatStatus.text ?? "123"
    }
    
    @objc func exitButton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
            
            self.tapButton.layer.opacity = 0
            self.bigAvatarCat.center = CGPoint(x: 64, y: 64)
            self.animateSize(width: 96,
                             height: 96)
            self.bigAvatarCat.clipsToBounds = true
            self.bigAvatarCat.layer.cornerRadius = 48
            self.bigAvatarCat.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
            self.bigAvatarCat.layer.borderWidth = 3
            
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0) {
                self.dimmingView.layer.opacity = 0.0
                self.bigAvatarCat.layer.opacity = 0
                self.dimmingView.layoutIfNeeded()
            }
        }
    }
   
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
   
}
