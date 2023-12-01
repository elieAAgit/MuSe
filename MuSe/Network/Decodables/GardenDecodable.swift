//
//  GardenDecodable.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

struct GardenDecodable: Decodable {
    let nhits: Int
    let parameters: GardenParameters
    let records: [GardenRecord]
}

// MARK: - Parameters
struct GardenParameters: Decodable {
    let dataset, format, timezone: String
    let rows, start: Int
    let facet: [String]
}

// MARK: - Record
struct GardenRecord: Decodable {
    let datasetid, recordid: String
    let fields: GardenFields
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct GardenFields: Decodable {
    let gardenName: String?
    let adress, city, county, region, postalCode: String?
    let description, codeID, webSite: String?
    let coordinates: [Double]?

    enum CodingKeys: String, CodingKey {
        case adress = "adresse"
        case city = "ville"
        case county = "departement"
        case region
        case description = "descriptif"
        case postalCode = "code_postal"
        case codeID = "code_id"
        case gardenName = "nom_du_jardin"
        case webSite = "site_web"
        case coordinates = "coordonnees_geographiques"
    }
}
