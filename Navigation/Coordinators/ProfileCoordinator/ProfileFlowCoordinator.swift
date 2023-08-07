//
//  ProfileFlowCoordinator.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

final class ProfileFlowCoordinator {
    
    var navControlles : UINavigationController?
    var login : String?
    
    func showNextScreen() {

        let viewController = Factory(flow: .profile, login: login!, navigation: navControlles ?? UINavigationController()).viewController

        guard let viewController  = viewController else {return}
        navControlles?.pushViewController(viewController, animated: true)
    }
    
    func showPhotoScreen() {

        let viewController = Factory(flow: .photo, login: "", navigation: navControlles ?? UINavigationController()).viewController

        guard let viewController  = viewController else {return}
        navControlles?.pushViewController(viewController, animated: true)
    }
}
