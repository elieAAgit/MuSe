//
//  Place.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import Foundation

struct Places {
    static var places = [Place]()
}

struct Place {
    let title: String
    let category: Category
    let latitude: Double
    let longitude: Double
    let favorite: Bool
    let adress: String?
    let opening: String?
    let phone: String?
    let internet: String?
    let description: String?
}
