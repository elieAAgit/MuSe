//
//  NetworkModel.swift
//  MuSe
//
//  Created by Elie ARquier on 15/04/2022.
//

import Foundation
import CoreData

final class NetworkModel {

    private var placeManager: PlaceManager?

    ///Launching the Database manager
    func start() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)

        placeManager?.deleteAll()
    }

    /// Decode and add museum objects to the database
    func museum(response: MuseumDecodable?) {
        guard let museums: [MuseumRecord] = response?.records else { return }

        for museum in museums {
            // Verify the museum has a name
            if let name = museum.fields.name {
                // Verify the museum has coordinates
                if let longitude = museum.geometry.coordinates?.first {
                    if let latitude = museum.geometry.coordinates?.last {
                        // Verify the museum is not in the database
                        if placeManager?.findPlaceFavoriteOrHistory(title: name, latitude: latitude,
                                                                    longitude: longitude) == false {
                            var detail = ""

                            if museum.fields.category != nil {
                                detail = museum.fields.category ?? ""
                            } else if museum.fields.otherName != nil {
                                detail = museum.fields.otherName ?? ""
                            }

                            var location = ""
                            let city = museum.fields.city ?? ""
                            let adress = museum.fields.adress ?? ""
                            let county = museum.fields.county ?? ""

                            if city != "" && adress != "" {
                                location = adress + ", " + city
                            } else if city != "" && adress != "" {
                                location = city
                            } else if city == "" && county != "" {
                                location = county
                            }

                            var opening = ""

                            if museum.fields.protEsp != nil {
                                opening = museum.fields.protEsp ?? ""
                                opening = opening.replacingOccurrences(of: ";", with: ", ")
                            } else if museum.fields.dompal != nil {
                                opening = museum.fields.dompal ?? ""
                                opening = opening.replacingOccurrences(of: ";", with: ", ")
                            }

                            var history = ""
                            var asset = ""

                            if museum.fields.history != nil {
                                history = museum.fields.history ?? ""
                            }

                            if museum.fields.asset != nil {
                                asset = museum.fields.asset ?? ""
                            }

                            let descript =  """
                                            \(history)
                                            \(asset)
                                            """

                            // Add the object
                            placeManager?.addPlace(title: name,
                                                   detail: detail,
                                                   category: Categories.museum,
                                                   longitude: longitude,
                                                   latitude: latitude,
                                                   adress: location,
                                                   opening: opening,
                                                   phone: museum.fields.phone,
                                                   internet: museum.fields.webSite,
                                                   description: descript)
                        }
                    }
                }
            }
        }
    }

    ///decode and add thetre objects to the database
    func theatre(response: TheatreDecodable?) {
        guard let theatres: [RecordTheatre] = response?.records else { return }

        for theatre in theatres {
            // Verify the theatre has a name
            if let name = theatre.fields.name {
                // Verify the theatre has coordinates
                if let longitude = theatre.geometry.coordinates?.first {
                    if let latitude = theatre.geometry.coordinates?.last {
                        // Verify the theatre is not in the database
                        if placeManager?.findPlaceFavoriteOrHistory(title: name, latitude: latitude,
                                                                        longitude: longitude) == false {

                            var location = ""
                            let city = theatre.fields.city ?? ""
                            let adress = theatre.fields.adress ?? ""
                            let county = theatre.fields.region ?? ""

                            if city != "" && adress != "" {
                                location = adress + ", " + city
                            } else if city != "" && adress != "" {
                                location = city
                            } else if city == "" && county != "" {
                                location = county
                            }

                            let multiplexe = theatre.fields.multiplexe ?? "inconnu"
                            let art = theatre.fields.categorieArtEtEssai ?? "inconnu"

                            let descript =  """
                                            Multiplexe: \(multiplexe)
                                            art et essai: \(art)
                                            Nombre d'ecrans:
                                            """

                            // Add the object
                            placeManager?.addPlace(title: name,
                                                   category: Categories.theatre,
                                                   longitude: longitude,
                                                   latitude: latitude,
                                                   adress: location,
                                                   opening: nil,
                                                   phone: nil,
                                                   internet: nil,
                                                   description: descript)
                        }
                    }
                }
            }
        }
    }

    ///decode and add garden objects to the database
    func garden(response: GardenDecodable?) {
        guard let gardens: [GardenRecord] = response?.records else { return }

        for garden in gardens {
            // Verify the garden has a name
            if let name = garden.fields.gardenName {
                // Verify the garden has coordinates
                if let longitude = garden.fields.coordinates?.last {
                    if let latitude = garden.fields.coordinates?.first {
                        // Verify the garden is not in the database
                        if placeManager?.findPlaceFavoriteOrHistory(title: name, latitude: latitude,
                                                                    longitude: longitude) == false {
                            var location = ""
                            let city = garden.fields.city ?? ""
                            let adress = garden.fields.adress ?? ""
                            let county = garden.fields.county ?? ""

                            if city != "" && adress != "" {
                                location = adress + ", " + city
                            } else if city != "" && adress != "" {
                                location = city
                            } else if city == "" && county != "" {
                                location = county
                            }

                            // Add the object
                            placeManager?.addPlace(title: name,
                                                   category: Categories.garden,
                                                   longitude: longitude,
                                                   latitude: latitude,
                                                   adress: location,
                                                   opening: nil,
                                                   phone: nil,
                                                   internet: garden.fields.webSite,
                                                   description: garden.fields.description)
                        }
                    }
                }
            }
        }
    }
}
