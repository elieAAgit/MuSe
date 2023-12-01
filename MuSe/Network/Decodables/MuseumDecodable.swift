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
    let name, otherName: String?
    let adress, city, county, region, cp: String?
    let history, asset, interest, themes: String?
    let category, dompal, protEsp: String?
    let phone,  webSite: String?

    enum CodingKeys: String, CodingKey {
        case name = "nomoff"
        case otherName = "autnom"
        case history = "hist"
        case category = "categ"
        case dompal, themes
        case protEsp = "prot_esp"
        case asset = "atout"
        case interest = "interet"
        case county = "dpt"
        case city = "ville_m"
        case adress = "adrl1_m"
        case region = "region"
        case cp = "cp_m"
        case phone = "tel_m"
        case webSite = "url_m"
    }
}

// MARK: - Geometry
struct MuseumGeometry: Decodable {
    let type: String
    let coordinates: [Double]?
}
