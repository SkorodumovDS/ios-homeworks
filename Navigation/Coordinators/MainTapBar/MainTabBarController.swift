//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 02.08.2023.
//

import UIKit

final class MainTabBarController : UITabBarController {
    
    private let feedVC = Factory(flow: .feed, login: "")
    private let profileVC = Factory(flow: .profileinfo, login: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControlles()
    }
    
    private func setControlles() {
        viewControllers = [feedVC.navigationController, profileVC.navigationController]
    }
}
