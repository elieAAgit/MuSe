//
//  Category.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import Foundation

struct Category {
    let title: String
    let id: String
}

struct Categories {
    static var categories: [Category] = [museum,
                                         theatre,
                                         garden,
                                         library]

    static let museum = Category(title: "Musée", id: "Museum")
    static let theatre = Category(title: "Cinéma", id: "Theatre")
    static let garden = Category(title: "Jardin", id: "Garden")
    static let library = Category(title: "Bibliothèque", id: "Library")
}
