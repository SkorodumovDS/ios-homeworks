//
//  LogInViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.05.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate : LoginViewControllerDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.borderColor = CGColor(srgbRed: 211, green: 211, blue: 211, alpha: 1)
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 10
        
        return contentView
    }()
    
    private lazy var stack: UIStackView  = {
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        //stack.clipsToBounds = true
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var emptyView: UIView = {
        
        let emView = UIView()
        emView.translatesAutoresizingMaskIntoConstraints = false
        emView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        emView.layer.borderWidth = 0.5
        return emView
    }()
    
    private lazy var login: UITextField = { [unowned self] in
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Email or phone"
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
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var password: UITextField = { [unowned self] in
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "Enter text here"
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
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(patternImage: UIImage(named: "BluePixel")!)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var logo: UIImageView = {
        
        let image  = UIImage(named: "Logo")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        return avatar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    init(loginDelegate: LoginViewControllerDelegate) {
        self.loginDelegate = loginDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom = 0.0 + (keyboardHeight ?? 0.0)
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    func setupConstraints() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.heightAnchor.constraint(equalToConstant: 100),
            
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 510),
            
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            stack.heightAnchor.constraint(equalToConstant: 100.5),
            
            login.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
            login.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
            login.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 0),
            login.heightAnchor.constraint(equalToConstant: 50),
            
            emptyView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
            emptyView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
            emptyView.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 0),
            emptyView.heightAnchor.constraint(equalToConstant: 0.5),
            
            password.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 0),
            password.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 0),
            password.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 0),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            loginButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            loginButton.topAnchor.constraint(
                equalTo: password.bottomAnchor,
                constant: 16.0
            ),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        guard let delegate = loginDelegate else { return }
        
        let login  = login.text ?? "Skorodumov"
        let password = password.text ?? "34525543"
        
        if delegate.check(typedLogin: login, typedPassword: password)
        {
            let profile = User(login: login, fullName: "Skorodumov Dmitriy", status: "Writing something...", avatar: UIImage(named: "20")!)
            let curUser = CurrentUserService()
            curUser.initializeUser(user: profile)
            
            let pvView = ProfileViewController()
            pvView.initUser(user: profile)
            navigationController?.pushViewController(pvView, animated: true)}
        
        else {
            let alert = UIAlertController(title: "authorization error", message: "Incorrect login", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
        }
    }
    private func setupView() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubviews() {
        
        contentView.addSubview(logo)
        stack.addArrangedSubview(login)
        stack.addArrangedSubview(emptyView)
        stack.addArrangedSubview(password)
        contentView.addSubview(stack)
        contentView.addSubview(loginButton)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
