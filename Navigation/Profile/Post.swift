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
                description: """
                The Sun is the star at the center of the Solar System. It is a nearly perfect ball of hot plasma,[18][19] heated to incandescence by nuclear fusion reactions in its core. The Sun radiates this energy mainly as light, ultraviolet, and infrared radiation, and is the most important source of energy for life on Earth.
                """,
                image: "Sun",
                likes: 10,
                views: 100
            ),
            PostModel(
                author: "Earthman",
                description: """
The Moon is Earth's only natural satellite. It is the fifth largest satellite in the Solar System and the largest and most massive relative to its parent planet,[f] with a diameter about one-quarter that of Earth (comparable to the width of Australia).[16] The Moon is a planetary-mass object with a differentiated rocky body, making it a satellite planet under the geophysical definitions of the term and larger than all known dwarf planets of the Solar System.[17] It lacks any significant atmosphere, hydrosphere, or magnetic field. Its surface gravity is about one-sixth of Earth's at 0.1654 g, with Jupiter's moon Io being the only satellite in the Solar System known to have a higher surface gravity and density.
""",
                image: "Moon",
                likes: 20,
                views: 100
            ),
            PostModel(
                author: "Lazy358",
                description: """
A doughnut or donut (/ˈdoʊnət/) is a type of food made from leavened fried dough.[1]: 275  It is popular in many countries and is prepared in various forms as a sweet snack that can be homemade or purchased in bakeries, supermarkets, food stalls, and franchised specialty vendors. Doughnut is the traditional spelling, while donut is the simplified version; the terms are used interchangeably.
""",
                image: "Donut",
                likes: 30,
                views: 50
            ),
            PostModel(
                author: "Lazy576",
                description: """
A black hole is a region of spacetime where gravity is so strong that nothing, including light or other electromagnetic waves, has enough energy to escape its event horizon.[2] The theory of general relativity predicts that a sufficiently compact mass can deform spacetime to form a black hole.[3][4] The boundary of no escape is called the event horizon. Although it has a great effect on the fate and circumstances of an object crossing it, it has no locally detectable features according to general relativity.[5] In many ways, a black hole acts like an ideal black body, as it reflects no light.
""",
                image: "BlackHole",
                likes: 10,
                views: 10
            )
        ]
    }
}
