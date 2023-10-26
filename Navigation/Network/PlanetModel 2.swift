//
//  PlanetModel.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 07.09.2023.
//

import Foundation

struct PlanetModel :Decodable{
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String

    enum CodingKeys : String, CodingKey {
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case name
        case diameter
    }
}
