//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 17.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    /*
    private lazy var changeTitle: UIButton = {
        let button = UIButton()
        //button.frame = CGRect(x: 166, y: 264, width: 200, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = CGColor(srgbRed: 0, green: 191, blue: 255, alpha: 1)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(changeTitleCommand), for: .touchUpInside)
        return button
    }()
    */
    var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
       
        profileView = ProfileHeaderView()
        view.addSubview(profileView)
        //view.addSubview(changeTitle)
        //setupConstraintsProfile()
        // Do any additional setup after loading the view.
    }
    
    /*
    func setupConstraintsProfile() {
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            profileView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 0.0
            ),
            profileView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: 0.0
            ),
            profileView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            
            profileView.heightAnchor.constraint(equalToConstant: 200),
            
            changeTitle.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 0.0
            ),
            changeTitle.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: 0.0
            ),
            changeTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
            
        ])
    }
    */
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileView.frame = view.safeAreaLayoutGuide.layoutFrame
        
    }
    @objc func changeTitleCommand(_ sender: UIButton) {
        title = "New title"
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
