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
    var fakeResult:  Result<Bool, Error>!
  
    
    func check(secret: String, completion: (Result<Bool, Error>) -> Void) {
        completion(fakeResult)
    }
}
