//
//  FeedViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.04.2023.
//

import UIKit

class FeedViewController: UIViewController {

    var postText = Post(title: "New post")
    
    private lazy var actionButton: UIButton = {
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           button.setTitle("Перейти", for: .normal)
           button.setTitleColor(.systemBlue, for: .normal)
           
           return button
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(actionButton)
                
                let safeAreaLayoutGuide = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    actionButton.leadingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.leadingAnchor,
                        constant: 20.0
                    ),
                    actionButton.trailingAnchor.constraint(
                        equalTo: safeAreaLayoutGuide.trailingAnchor,
                        constant: -20.0
                    ),
                    actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                    actionButton.heightAnchor.constraint(equalToConstant: 44.0)
                ])
                
                actionButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.postTitle = postText.title
        self.navigationController?.pushViewController(postViewController, animated: false)
            
        //present(postViewController, animated: false)
        }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
