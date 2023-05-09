//
//  Post.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.05.2023.
//

import UIKit

struct PostModel {
    let author: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

extension PostModel {
    
    static func make() -> [PostModel] {
        [
            PostModel(
                author: "Earthman",
                description: "Battle fot the Sun",
                image: "Sun",
                likes: 10,
                views: 100
            ),
            PostModel(
                author: "Earthman",
                description: "Moon",
                image: "Moon",
                likes: 20,
                views: 100
            ),
            PostModel(
                author: "Lazy358",
                description: "Donut",
                image: "Donut",
                likes: 30,
                views: 50
            ),
            PostModel(
                author: "Lazy576",
                description: "Black hole",
                image: "BlackHole",
                likes: 10,
                views: 10
            )
        ]
    }
}
