//
//  MuseumDecodable.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

struct MuseumDecodable: Decodable {
    var nhits: Int
    var parameters: MuseumParameters
    var records: [MuseumRecord]
}

// MARK: - Parameters
struct MuseumParameters: Decodable {
    let dataset, timezone: String
    let rows, start: Int
    let format: String
    let facet: [String]
}

// MARK: - Record
struct MuseumRecord: Decodable {
    let datasetidMuseum: String
    let recordidMuseum: String
    let fields: MuseumFields
    let geometry: MuseumGeometry
    let record_timestampMuseum: String

    enum CodingKeys: String, CodingKey {
        case datasetidMuseum = "datasetid"
        case recordidMuseum = "recordid"
        case fields = "fields"
        case geometry
        case record_timestampMuseum = "record_timestamp"

    }
}

// MARK: - Fields
struct MuseumFields: Decodable {
    let name: String?
    let adress, city, county, region, cp: String?
    let phone,  webSite: String?

    enum CodingKeys: String, CodingKey {
        case name = "nom_officiel_du_musee"
        case county = "departement"
        case city = "commune"
        case adress = "adresse"
        case region = "region_administrative"
        case cp = "code_postal"
        case phone = "telephone"
        case webSite = "url"
    }
}

// MARK: - Geometry
struct MuseumGeometry: Decodable {
    let type: String
    let coordinates: [Double]?
}
