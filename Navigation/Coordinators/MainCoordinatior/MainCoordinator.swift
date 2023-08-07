//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp : MainCoordinator {
    func startApplication() -> UIViewController {
        return MainTabBarController()
    }
}
