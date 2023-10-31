//
//  Checker.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 16.06.2023.
//

import Foundation

class Checker {
    static let shared: Checker = {
        let instance = Checker()
        // конфигурация
        return instance
    }()
    private let login: String = "Skorodumov"
    private let passwqord: String = "34525543"
    
    /// Инициализатор синглтона всегда должен быть скрытым
    private init() {}
    func check( typedLogin:String, typedPassword:String) -> Bool{
        if typedLogin == login && typedPassword == passwqord {
            return true
        }else
        {return false}
    }
}

protocol LoginViewControllerDelegate : AnyObject {
     
    func check( typedLogin:String, typedPassword:String) throws -> Bool
    func signUp( typedLogin:String, typedPassword:String) throws -> Bool
}

class LoginInspector: LoginViewControllerDelegate {
    func signUp(typedLogin: String, typedPassword: String) throws -> Bool {
        var checkResult = false
        if typedLogin == ""
            {throw AppError.emptyLogin}
        else if String(typedPassword) == ""
            {throw AppError.emptyPassword}
        else {
            let checkService = CheckerService()
            checkService.signUp(email: typedLogin, password: typedPassword as String) {_signData,_error in
                if let _error {
                    checkResult = false
                }
                
                if let _signData {
                    checkResult = true
                }
            }
        }
        if checkResult == false {throw AppError.signUpError}
        else {
            return checkResult}
    }

    var delegate: (LoginViewControllerDelegate)?
    
    func check( typedLogin:String , typedPassword:String) throws -> Bool {
        var checkResult = false
        if typedLogin == ""
            {throw AppError.emptyLogin}
        else if String(typedPassword) == ""
            {throw AppError.emptyPassword}
        else {
            let checkService = CheckerService()
                    checkService.checkCredentials(email: typedLogin, password: typedPassword) { _AuthDataResult,_authError in
                        
                        if let _authError {
                            checkResult = false
                        }
                        
                        if let _AuthDataResult {
                            checkResult = true
                        }
                    }
            checkResult = true
            if checkResult == false {throw AppError.unauthorized}
            else {
                return checkResult}}
    }
}

protocol LoginFactory {
     func makeLoginInspector () -> LoginInspector
}


struct MyLoginFactory : LoginFactory {
    func makeLoginInspector() -> LoginInspector{
        let inspector = LoginInspector()
        return inspector
    }
}
