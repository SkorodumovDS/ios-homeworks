//
//  User.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 08.06.2023.
//

import Foundation
import UIKit

public class User {
    var login: String
    var fullName: String
    var status: String
    var avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
}

protocol UserService {
    
    var currentUser : User? {get set}
}

extension UserService {
    func authorize( login: String) -> User? {
        if login == currentUser?.login {
            return currentUser
        }else {return nil}
    }
}

public class CurrentUserService : UserService {
    var currentUser: User?
    
    func initializeUser( user: User?) {
        self.currentUser = user
    }
}

public class TestUserSevice : UserService {
    
    var currentUser: User? = User(login: "Test", fullName: "Test", status: "TestStatus", avatar: UIImage(named: "19")!)
    
    
}
