//
//  InfoViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    var coordinator: FeedFlowCoordinator?
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
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "My Alert", message: "This is an alert.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("What's wrong", comment: "Something went wrong"), style: .default, handler: { _ in
            NSLog("The \"Something went wrong\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }    /*
          /*
           // MARK: - Navigation
           
           // In a storyboard-based application, you will often want to do a little preparation before navigation
           override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
           }
           */
          */
}
