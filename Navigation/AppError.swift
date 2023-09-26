//
//  AppError.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 22.08.2023.
//

import Foundation

enum AppError: Error {
    case unauthorized
    case networkError
    case wrongPassword
    case emptyLogin
    case emptyPassword
    case signUpError
}
