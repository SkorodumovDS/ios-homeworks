//
//  Factory.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

final class Factory {
    enum Flow {
        case feed
        case profileinfo
        case post
        case profile
    }
    
    private let flow : Flow
    private let login : String
    private (set) var navigationController = UINavigationController()
    private (set) var viewController : UIViewController!
   
    init(flow: Flow, login: String) {
        self.flow = flow
        self.login = login
        startModule()
    }
    
    private func startModule() {
        
        switch flow {
        case .feed:
            let feedModel = FeedModel()
            let feedFlowCoordinator = FeedFlowCoordinator()
            let feedViewModel = FeedViewModel(feedModel: feedModel, coordinator: feedFlowCoordinator)
            let FeedViewController = FeedViewController(feedViewModel: feedViewModel)
            FeedViewController.title = "News"
            FeedViewController.view.backgroundColor = .systemBackground
            FeedViewController.tabBarItem.title = "Feed"
            FeedViewController.tabBarItem.image = UIImage(systemName: "house")
            feedFlowCoordinator.navControlles = navigationController
            navigationController.setViewControllers([FeedViewController], animated: true)
            
        case .profileinfo:
            let factory = MyLoginFactory()
            let loginInspector = factory.makeLoginInspector()
            let profileFlowCoordinator = ProfileFlowCoordinator()
            let loginViewController = LogInViewController(loginDelegate: loginInspector, coordinator: profileFlowCoordinator)
            let loginInspectorObject = loginInspector
            loginInspectorObject.delegate = loginViewController as? any LoginViewControllerDelegate
            //ProfileViewController.title = "Profile"
            profileFlowCoordinator.navControlles = navigationController
            loginViewController.view.backgroundColor = .white
            loginViewController.tabBarItem.title = "Profile"
            loginViewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
            
            navigationController.setViewControllers([loginViewController], animated: true)
        case .post:
            let postViewController = PostViewController()
            viewController = postViewController
        case .profile:
            
            let profile = User(login: login, fullName: "Skorodumov Dmitriy", status: "Writing something...", avatar: UIImage(named: "20")!)
            let curUser = CurrentUserService()
            curUser.initializeUser(user: profile)
            
            let pvView = ProfileViewController()
            pvView.initUser(user: profile)
            viewController = pvView
        }
    }
    
}
