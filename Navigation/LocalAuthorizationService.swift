//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 30.11.2023.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService{
    
    var biometryEvaluated: Bool  = false
    var context = LAContext()
    var error: NSError?  = nil
    var policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
   
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) async {
        biometryEvaluated = context.canEvaluatePolicy(policy, error: &error)
        if (error != nil) {
            print(error?.localizedDescription ?? "some error")
            authorizationFinished(false)
        }
        context.evaluatePolicy(policy, localizedReason: "time saved") { ifSucsess,error in
            if (error != nil) {
                authorizationFinished(false)
            }
            if ifSucsess {
                authorizationFinished(true)
                
            }
        }
    }
}
