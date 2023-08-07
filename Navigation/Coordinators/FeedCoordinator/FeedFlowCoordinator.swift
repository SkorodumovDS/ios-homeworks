//
//  FeedFlowCoordinator.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

final class FeedFlowCoordinator {
    
    var navControlles : UINavigationController?
    
    func showNextScreen() {
        let viewController = Factory(flow: .post, login: "", navigation: navControlles ?? UINavigationController()).viewController

        guard let viewController  = viewController else {return}
        navControlles?.pushViewController(viewController, animated: true)
    }
    
    func showInfoScreen() {
        let viewController = Factory(flow: .info, login: "", navigation: navControlles ?? UINavigationController()).viewController

        guard let viewController  = viewController else {return}
        navControlles?.pushViewController(viewController, animated: true)
        //navControlles?.present(viewController, animated: true)
    }
}
