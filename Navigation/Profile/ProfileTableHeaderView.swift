//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 11.05.2023.
//

import UIKit

class TableSectionFooterHeaderView: UITableViewHeaderFooterView {

    // MARK: - Subviews
    var curUser : User?
    private lazy var profileView: ProfileHeaderView = {
        
        let prView = ProfileHeaderView()
        return prView
    }()

    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func initUser( user: User?) {
        curUser = user!
        profileView.initializeUser(user: curUser)
    }
    // MARK: - Private
    
    private func addSubviews() {
        contentView.addSubview(profileView)
    }
    
    private func setupConstraints() {
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 0),
            profileView.trailingAnchor.constraint(
                equalTo:safeAreaLayoutGuide.trailingAnchor,
                constant: 0),
            profileView.heightAnchor.constraint(
                equalToConstant: 220),
            profileView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
}
