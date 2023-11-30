//
//  FeedModelMock.swift
//  NavigationTests
//
//  Created by Skorodumov Dmitry on 24.11.2023.
//

import Foundation

protocol FeedModelProtocol{
    func check(secret: String, completion: (Result<Bool, Error>) -> Void)
}

class FeedModelMock: FeedModelProtocol {
   // var fakeResult:  Result<Bool, Error>!
    let secretWord : String = "password"
    
    
    func check(secret: String, completion: (Result<Bool, Error>) -> Void) {
        if secret == secretWord {completion(.success(true))}
        else {completion(.failure(testError.someError))}
    }
}
