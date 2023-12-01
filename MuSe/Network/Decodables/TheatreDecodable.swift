//
//  TheatreDecodable.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

struct TheatreDecodable: Decodable {
    let nhits: Int
    let parameters: ParametersTheatre
    let records: [RecordTheatre]
}

// MARK: - Parameters
struct ParametersTheatre: Decodable {
    let dataset, timezone, format: String
    let rows, start: Int
    let facet: [String]
}

// MARK: - Record
struct RecordTheatre: Decodable {
    let datasetid, recordid: String
    let fields: FieldsTheatre
    let geometry: GeometryTheatre
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct FieldsTheatre: Decodable {
    let screens, seats: Int?
    let name, multiplexe, categorieArtEtEssai, labelArtEtEssai: String?
    let adress, city, urban, region: String?
    let latitude, longitude: String?

    enum CodingKeys: String, CodingKey {
        case name = "nom"
        case adress = "adresse"
        case screens = "ecrans"
        case seats = "fauteuils"
        case city = "commune"
        case latitude, longitude, multiplexe
        case region = "region_administrative"
        case categorieArtEtEssai = "categorie_art_et_essai"
        case labelArtEtEssai = "label_art_et_essai"
        case urban = "unite_urbaine"
    }
}

// MARK: - Geometry
struct GeometryTheatre: Decodable {
    let type: String
    let coordinates: [Double]? // first: longitude, second: latitude
}
