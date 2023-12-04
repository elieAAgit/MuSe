//
//  LibraryDecodable.swift
//  MuSe
//
//  Created by Elie Arquier on 14/04/2022.
//

import Foundation

struct LibraryDecodable: Decodable {
    let nhits: Int
    let parameters: LibraryParameters
    let records: [LibraryRecord]
}

// MARK: - Parameters
struct LibraryParameters: Decodable {
    let dataset, format, timezone: String
    let rows, start: Int
    let facet: [String]
}

// MARK: - Record
struct LibraryRecord: Decodable {
    let datasetidLibrary: String
    let recordidLibrary: String
    let fields: LibraryFields
    let geometry: LibraryGeometry
    let record_timestampLibrary: String

    enum CodingKeys: String, CodingKey {
        case datasetidLibrary = "datasetid"
        case recordidLibrary = "recordid"
        case fields
        case geometry
        case record_timestampLibrary = "record_timestamp"
    }
}

// MARK: - Fields
struct LibraryFields: Decodable {
    let adress, city, county: String?
    let name, otherName, detail, description: String?

    enum CodingKeys: String, CodingKey {
        case adress = "adresse"
        case county = "departement"
        case detail = "statut"
        case name = "nom_de_l_etablissement"
        case otherName = "libelle_2"
        case city = "ville"
        case description = "type_adresse"
    }
}

// MARK: - Geometry
struct LibraryGeometry: Decodable {
    let type: String
    let coordinates: [Double]?
}
