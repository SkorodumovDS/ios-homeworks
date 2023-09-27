//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

final class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControlles()
    }
    
    private func setControlles() {
       
        let feedNavController = UINavigationController()
        let profileNavController = UINavigationController()
        let documentsNavController = UINavigationController()
        
        let feedVC = Factory(flow: .feed, login: "", navigation: feedNavController)
        let profileVC = Factory(flow: .profileinfo, login: "", navigation: profileNavController)
        let documentsVC = Factory(flow: .documents, login: "", navigation: documentsNavController)
        
        viewControllers = [documentsVC.navigationController, feedVC.navigationController, profileVC.navigationController]
    }
}
