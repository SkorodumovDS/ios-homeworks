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
        let likedNavController = UINavigationController()
        let myGeolocationController = UINavigationController()
        
        let feedVC = Factory(flow: .feed, login: "", navigation: feedNavController)
        let profileVC = Factory(flow: .profileinfo, login: "", navigation: profileNavController)
        let likedVC = Factory(flow: .liked, login: "", navigation: likedNavController)
        let geoVC = Factory(flow: .geo, login: "", navigation: myGeolocationController)
        viewControllers = [feedVC.navigationController, profileVC.navigationController, likedVC.navigationController, geoVC.navigationController]
    }
}
