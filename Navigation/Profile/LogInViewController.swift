//
//  LogInViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.05.2023.
//

import UIKit

class LogInViewController: UIViewController {
    var delayCounter = 10
    private var loginDelegate : LoginViewControllerDelegate?
    var randomPassword: String = ""
    
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
        
        textField.placeholder = "Email or phone".localized()
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
        
        textField.placeholder = "Enter text here".localized()
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
        let buttonLog = CustomButton(title: "Log In".localized(), titleColor: .white, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.buttonPressed()
        }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog
        
    }()
    
    private lazy var signUpButton: UIButton = {
        let buttonLog = CustomButton(title: "Sign Up".localized(), titleColor: .white, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.signUp()
        }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog
        
    }()
    
    private lazy var logo: UIImageView = {
        
        let image  = UIImage(named: "Logo")
        let avatar =  UIImageView(image: image)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.clipsToBounds = true
        return avatar
    }()
    private let coordinator : ProfileFlowCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  UITraitCollection.current.userInterfaceStyle == .dark{
            Theme.current = .dark
        }else {
            Theme.current = .light
        }
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if  UITraitCollection.current.userInterfaceStyle == .dark{
            Theme.current = .dark
        }else {
            Theme.current = .light
        }
    }
    
    init(loginDelegate: LoginViewControllerDelegate, coordinator: ProfileFlowCoordinator) {
        self.loginDelegate = loginDelegate
        self.coordinator = coordinator
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
            contentView.heightAnchor.constraint(equalToConstant: 630),
            
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
            loginButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            signUpButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -16.0
            ),
            signUpButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16.0
            ),
            signUpButton.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: 16.0
            ),
            signUpButton.heightAnchor.constraint(equalToConstant: 50.0)
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
    
    @objc func buttonPressed() {
        
        guard let delegate = loginDelegate else { return }
        
        //let login  = login.text ?? "Skorodumov"
        //let password = password.text ?? "34525543"
        let login  = login.text ?? ""
        let passwordText = password.text?.description ?? ""
        do {
        try delegate.check(typedLogin: login, typedPassword: passwordText)
            coordinator.login = login
            coordinator.showNextScreen()}
        catch AppError.unauthorized {
        
            let alert = UIAlertController(title: "authorization error".localized(), message: "Incorrect login, Try again after".localized() +  String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(authorizeDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        
        catch AppError.emptyLogin {
           
            let alert = UIAlertController(title: "Login is empty".localized(), message: "Fill login field and try again after" + String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(emptyFieldDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        catch AppError.emptyPassword {
           
            let alert = UIAlertController(title: "Password is empty".localized(), message: "Fill password field and try again after".localized() + String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(emptyFieldDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        catch {}
    }
    
    @objc func signUp() {
        
        guard let delegate = loginDelegate else { return }
        
        //let login  = login.text ?? "Skorodumov"
        //let password = password.text ?? "34525543"
        let login  = login.text ?? ""
        let passwordText = password.text?.description ?? ""
        do {
            try delegate.signUp(typedLogin: login, typedPassword: passwordText)
            coordinator.login = login
            coordinator.showNextScreen()}
        catch AppError.signUpError {
        
            let alert = UIAlertController(title: "sign up error".localized(), message: "Invalid format for login or password field, or check network, Try again after".localized() + String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(signUpDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        
        catch AppError.emptyLogin {
           
            let alert = UIAlertController(title: "Login is empty".localized(), message: "Fill login field and try again after".localized() + String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(emptyFieldDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        catch AppError.emptyPassword {
           
            let alert = UIAlertController(title: "Password is empty".localized(), message: "Fill password field and try again after".localized() + String(self.delayCounter) + "seconds".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Try again".localized(), comment: "Default action"), style: .default, handler: { _ in
                //NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true)
            alert.actions.first?.isEnabled = false
            self.delayCounter = 10
            let timer = Timer.scheduledTimer(timeInterval: 1.0,
                                             target: self,
                                             selector: #selector(emptyFieldDelay),
                                             userInfo: alert,
                                             repeats: true)
            
        }
        catch {}
    }
    
    @objc private func authorizeDelay(timer: Timer) {
        guard var context = timer.userInfo as? UIAlertController else {return}
        self.delayCounter = self.delayCounter - 1
    
        context.message = "Incorrect login, Try again after".localized() + String(self.delayCounter) + "seconds".localized()
        if self.delayCounter == 0 {
            timer.invalidate()
            context.actions.first?.isEnabled = true
            context.message = "Incorrect login, Try again".localized()
        }
    }
    
    @objc private func emptyFieldDelay(timer: Timer) {
        guard var context = timer.userInfo as? UIAlertController else {return}
        self.delayCounter = self.delayCounter - 1
    
        context.message = "Fill login and password fields and try again after".localized() + String(self.delayCounter) + "seconds".localized()
        if self.delayCounter == 0 {
            timer.invalidate()
            context.actions.first?.isEnabled = true
            context.message = "Login is empty".localized()
        }
    }
    
    @objc private func signUpDelay(timer: Timer) {
        guard var context = timer.userInfo as? UIAlertController else {return}
        self.delayCounter = self.delayCounter - 1
    
        context.message = "Fill correct login and password fields, check network connection and try again after".localized() + String(self.delayCounter) + "seconds".localized()
        if self.delayCounter == 0 {
            timer.invalidate()
            context.actions.first?.isEnabled = true
            context.message = "Sign up error".localized()
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
    contentView.addSubview(signUpButton)
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
