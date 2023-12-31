//
//  ApiKeys.swift
//  MuSe
//
//  Created by Elie Arquier on 14/04/2022.
//

import Foundation

enum Methods: String {
    case get = "GET"
    case post = "POST"
}

struct ApiKey {
    var base: String
    var body: String
    var method: Methods
}

// NO GITIGNORE : APIs are public
struct ApiKeys {
    // MARK: - culture.gouv
    static private let cultureBase = "https://data.culture.gouv.fr/api/records/1.0/"

    // MARK: - Museum
    static private let datasetMuseum = "search/?dataset=musees-de-france-base-museofile"
    static private let facetMuseum = "&q=&facet=dompal&facet=region&rows=1500"
    static private var museumBody: String {
        return datasetMuseum + facetMuseum
    }

    // MARK: - Theatre
    static private let datasetTheatre = "search/?dataset=etablissements-cinematographiques"
    static private let facetTheatre = "&q=&facet=region_administrative&facet=genre&facet=multiplexe&facet=zone_de_la_commune&rows=3000"

    static private var theatreBody: String {
        return datasetTheatre + facetTheatre
    }

    // MARK: - Garden
    static private let datasetGarden = "search/?dataset=liste-des-jardins-remarquables"
    static private let facetGarden = "&q=&facet=region&facet=departement&rows=300"

    static private var gardenBody: String {
        return datasetGarden + facetTheatre
    }

    // MARK: - Keys
    static var museumUrl = ApiKey(base: cultureBase, body: museumBody, method: .get)
    static var theatreUrl = ApiKey(base: cultureBase, body: theatreBody, method: .get)
    static var gardenUrl = ApiKey(base: cultureBase, body: gardenBody, method: .get)
}
