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
        }else {return false}
    }
}

protocol LoginViewControllerDelegate : AnyObject {
     
    func check( typedLogin:String, typedPassword:String) -> Bool
}

/*
 extension LoginViewControllerDelegate {
    
    func check( typedLogin:String , typedPassword:String) -> Bool {
        Checker.shared.check(typedLogin: typedLogin, typedPassword: typedPassword)
    }
}
*/

class LoginInspector: LoginViewControllerDelegate {
    var delegate: (LoginViewControllerDelegate)?
    func check( typedLogin:String , typedPassword:String) -> Bool {
        Checker.shared.check(typedLogin: typedLogin, typedPassword: typedPassword)
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
