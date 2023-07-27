//
//  FeedModel.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 19.07.2023.
//

import Foundation

class FeedModel {
    
    let secretWord : String = "password"
    
    func Check(secret:String) -> Bool {
        if secret == secretWord {return true}
        else {return false}
    }
}
