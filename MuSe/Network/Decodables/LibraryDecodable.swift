//
//  LibraryDecodable.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

struct LibraryDecodable: Decodable {
    let nhits: Int
    let parameters: LibraryParameters
    let records: [LibraryRecord]
}

// MARK: - Parameters
struct LibraryParameters: Decodable {
    let dataset, timezone, format: String
    let rows, start: Int
    let facet: [String]
}

// MARK: - Record
struct LibraryRecord: Decodable {
    let datasetid, recordid: String
    let fields: LibraryFields
    let geometry: LibraryGeometry
    let recordTimestamp: String

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid
        case fields = "fields"
        case geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - Fields
struct LibraryFields: Decodable {
    let adress, city, postalCode: String?
    let name, detail, description: String?

    enum CodingKeys: String, CodingKey {
        case adress = "voie"
        case postalCode = "cp"
        case detail = "comment"
        case name = "libelle1"
        case city = "adresse_ville"
        case description = "type_adresse"
    }
}

// MARK: - Geometry
struct LibraryGeometry: Decodable {
    let type: String
    let coordinates: [Double]?
}
