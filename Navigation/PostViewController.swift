//
//  PostViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.04.2023.
//

import UIKit

class PostViewController: UIViewController {

    var postTitle : String = "null"
    var coordinator :FeedFlowCoordinator
    
    init(coordinator: FeedFlowCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = postTitle
        view.backgroundColor = .systemYellow
        navigationItem.title = postTitle
        
        let info = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoPressed(_:)))

        navigationItem.rightBarButtonItem =  info
        // Do any additional setup after loading the view.
    }
    
    @objc func infoPressed(_ sender: UIButton) {
           /*
            let infoViewController = InfoViewController()
            
        infoViewController.modalTransitionStyle = .flipHorizontal // flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet // pageSheet
            
            present(infoViewController, animated: true)
            */
        self.coordinator.showInfoScreen()
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
