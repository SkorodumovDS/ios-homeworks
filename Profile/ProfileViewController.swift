//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 17.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
       
        profileView = ProfileHeaderView()
        view.addSubview(profileView)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileView.frame = CGRect(x: 0, y: 54, width: view.frame.width, height: view.frame.height - 54)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
