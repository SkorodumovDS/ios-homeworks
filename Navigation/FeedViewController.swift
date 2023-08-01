//
//  FeedViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.04.2023.
//

import UIKit

class FeedViewController: UIViewController {

    var postText = Post(title: "New post")
    private let feedViewModel: FeedViewModel
    
    private lazy var actionButton: UIButton = {
        let buttonLog = CustomButton(title: "Перейти", titleColor: .black, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.buttonPressed()
                }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog

       }()
    
    private lazy var password: UITextField = { [unowned self] in
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Enter password here"
        textField.font = UIFont.systemFont(ofSize: 16)
        //textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.textColor = .black
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var checkGuessButton: UIButton = {
        let buttonLog = CustomButton(title: "Check password", titleColor: .black, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.Check()
                }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog
        
    }()
    
    private lazy var passwordStatus : UILabel = {
        
        let passStatus = UILabel()
        passStatus.translatesAutoresizingMaskIntoConstraints = false
        passStatus.textColor = .gray
        
        return passStatus
    }()
    
    init(feedViewModel: FeedViewModel) {
        
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindFeedViewModel() {
        feedViewModel.stateChanged = { [weak self] state in
            switch state{
            case .initial :
                self?.passwordStatus.backgroundColor = .white
            case .passwordChecked:
                self?.passwordStatus.backgroundColor = .green
            case .passwordUnchecked:
                self?.passwordStatus.backgroundColor = .red
            case .nextScreen:
                let postViewController = PostViewController()
                postViewController.postTitle = self!.postText.title
                self?.navigationController?.pushViewController(postViewController, animated: false)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(actionButton)
        view.addSubview(password)
        view.addSubview(checkGuessButton)
        view.addSubview(passwordStatus)
        bindFeedViewModel()
        
                let safeAreaLayoutGuide = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    actionButton.leadingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: 20.0
                    ),
                    actionButton.trailingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.trailingAnchor,
                        constant: -20.0
                    ),
                    actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                    actionButton.heightAnchor.constraint(equalToConstant: 44.0),
                    
                    password.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    password.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    password.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20),
                    password.heightAnchor.constraint(equalToConstant: 50),
                    
                    checkGuessButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    checkGuessButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    checkGuessButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
                    checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
                    
                    passwordStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    passwordStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    passwordStatus.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 20),
                    passwordStatus.heightAnchor.constraint(equalToConstant: 20)
                
                ])
                
    }
    
    @objc func buttonPressed() {
        feedViewModel.changeState(.nextButtonTapped)
        }
    
    @objc func Check() {
        feedViewModel.secret = password.text ?? "password"
        feedViewModel.changeState(.passwordButtonTapped)
        }

}
