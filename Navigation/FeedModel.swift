//
//  FeedModel.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 19.07.2023.
//

import Foundation

class FeedModel {
    
    let secretWord : String = "password"
    
    func check(secret:String, completion: @escaping (Result<Bool, AppError>) -> Void) {
        if secret == secretWord {completion(.success(true))}
        else {completion(.failure(.wrongPassword))}
    }
}
