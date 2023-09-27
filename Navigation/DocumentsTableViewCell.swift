//
//  DocumentsTableViewCell.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 27.09.2023.
//


import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    
    private lazy var postTitle : UILabel = {
        let titlePost = UILabel()
        titlePost.translatesAutoresizingMaskIntoConstraints = false
        titlePost.text = "..."
        titlePost.font = .systemFont(ofSize: 20,weight: .bold)
        titlePost.textColor = UIColor.black
        titlePost.numberOfLines = 2
        
        return titlePost
        
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .subtitle,
            reuseIdentifier: reuseIdentifier
        )
        addsubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addsubviews(){
        addSubview(postTitle)
    }
    
    private func setupConstrains() {
        
        let safeAreaLayoutGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            postTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            postTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            postTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            postTitle.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    
    func update(_ text: String ) {
        postTitle.text = text
    }
}

