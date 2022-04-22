//
//  NetworkModel.swift
//  MuSe
//
//  Created by Qattus on 15/04/2022.
//

import Foundation

final class NetworkModel {

    func museum(response: MuseumDecodable?) {
        guard let museums: [MuseumRecord] = response?.records else { return }

        for museum in museums {
            if let name = museum.fields.name {
                if let longitude = museum.geometry.coordinates?.first {
                    if let latitude = museum.geometry.coordinates?.last {

                        let city = museum.fields.city ?? ""
                        var adress = ""
                        var county = ""

                        if city != "" {
                            adress = museum.fields.adress ?? ""
                            county = museum.fields.county ?? ""
                        }

                        let location = adress + " " + city + " " + county

                        let place = Place(title: name,
                                          category: Categories.museum,
                                          latitude: latitude,
                                          longitude: longitude,
                                          favorite: false,
                                          adress: location,
                                          opening: nil,
                                          phone: museum.fields.phone,
                                          internet: museum.fields.webSite,
                                          description: nil)

                        Places.places.append(place)
                    }
                }
            }
        }
    }

    func theatre(response: TheatreDecodable?) {
        guard let theatres: [RecordTheatre] = response?.records else { return }

        for theatre in theatres {
            if let name = theatre.fields.name {
                if let longitude = theatre.geometry.coordinates?.first {
                    if let latitude = theatre.geometry.coordinates?.last {

                        let city = theatre.fields.city ?? ""
                        var adress = ""
                        var county = ""

                        if city != "" {
                            adress = theatre.fields.adress ?? ""
                            county = theatre.fields.region ?? ""
                        }

                        let location = adress + " " + city + " " + county

                        let place = Place(title: name,
                                          category: Categories.theatre,
                                          latitude: latitude,
                                          longitude: longitude,
                                          favorite: false,
                                          adress: location,
                                          opening: nil,
                                          phone: nil,
                                          internet: nil,
                                          description: nil)

                        Places.places.append(place)
                    }
                }
            }
        }
    }

    func garden(response: GardenDecodable?) {
        guard let gardens: [GardenRecord] = response?.records else { return }

        for garden in gardens {
            if let name = garden.fields.gardenName {
                if let longitude = garden.fields.coordinates?.first {
                    if let latitude = garden.fields.coordinates?.last {

                        let city = garden.fields.city ?? ""
                        var adress = ""
                        var county = ""

                        if city != "" {
                            adress = garden.fields.adress ?? ""
                            county = garden.fields.county ?? ""
                        }

                        let location = adress + " " + city + " " + county

                        let place = Place(title: name,
                                          category: Categories.garden,
                                          latitude: latitude,
                                          longitude: longitude,
                                          favorite: false,
                                          adress: location,
                                          opening: nil,
                                          phone: nil,
                                          internet: garden.fields.webSite,
                                          description: garden.fields.description)

                        Places.places.append(place)
                    }
                }
            }
        }
    }

    func library(response: LibraryDecodable?) {
        guard let libraries: [LibraryRecord] = response?.records else { return }

        for library in libraries {
            if let name = library.fields.name {
                if let longitude = library.geometry.coordinates?.first {
                    if let latitude = library.geometry.coordinates?.last {

                        let city = library.fields.city ?? ""
                        var adress = ""
                        var county = ""

                        if city != "" {
                            adress = library.fields.adress ?? ""
                            county = library.fields.postalCode ?? ""
                        }
        
                        let location = adress + " " + city + " " + county

                        let place = Place(title: name,
                                          category: Categories.library,
                                          latitude: latitude,
                                          longitude: longitude,
                                          favorite: false,
                                          adress: location,
                                          opening: nil,
                                          phone: nil,
                                          internet: nil,
                                          description: library.fields.description)

                        Places.places.append(place)
                    }
                }
            }
        }
    }
}
