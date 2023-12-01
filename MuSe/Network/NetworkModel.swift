//
//  NetworkModel.swift
//  MuSe
//
//  Created by Qattus on 15/04/2022.
//

import Foundation
import CoreData

final class NetworkModel {

    private var placeManager: PlaceManager?
    private var saveFavorites = [Place]()
    private var saveHistory = [Place]()

    func start() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)

        saveFavorites = placeManager?.findPlacesFavorite() ?? []
        saveHistory = placeManager?.findPlacesHistory() ?? []

        placeManager?.deleteAll()
    }

    func museum(response: MuseumDecodable?) {
        guard let museums: [MuseumRecord] = response?.records else { return }

        for museum in museums {
            if let name = museum.fields.name {
                if let longitude = museum.geometry.coordinates?.first {
                    if let latitude = museum.geometry.coordinates?.last {

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

    func theatre(response: TheatreDecodable?) {
        guard let theatres: [RecordTheatre] = response?.records else { return }

        for theatre in theatres {
            if let name = theatre.fields.name {
                if let longitude = theatre.geometry.coordinates?.first {
                    if let latitude = theatre.geometry.coordinates?.last {

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
                        var artCategory = ""

                        let descript =  """
                                        Multiplexe: \(multiplexe)
                                        art et essai: \(art)
                                        Nombre d'ecrans:
                                        """

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

    func garden(response: GardenDecodable?) {
        guard let gardens: [GardenRecord] = response?.records else { return }

        for garden in gardens {
            if let name = garden.fields.gardenName {
                if let longitude = garden.fields.coordinates?.last {
                    if let latitude = garden.fields.coordinates?.first {

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
        
                        let location = adress + " " + city

                        placeManager?.addPlace(title: name,
                                               category: Categories.library,
                                               longitude: longitude,
                                               latitude: latitude,
                                               adress: location,
                                               opening: nil,
                                               phone: nil,
                                               internet: nil,
                                               description: library.fields.description)
                    }
                }
            }
        }
    }
    
    private func saveFavoritesAndHistory() -> Bool {
        guard let favorites = placeManager?.findPlacesFavorite() else { return true }
        guard let history = placeManager?.findPlacesHistory() else { return true }

        saveFavorites = favorites
        saveHistory = history

        return true
    }

    func loadingFavoritesAndHistory() {
        for favorite in saveFavorites {
            guard let title = favorite.title else { return }
    
            if ((placeManager?.findPlace(title)) != nil) {
                placeManager?.updateFavorite(favorite)
            }
        }

        for history in saveHistory {
            guard let title = history.title else { return }
    
            if ((placeManager?.findPlace(title)) != nil) {
                placeManager?.updateHistory(history)
            }
        }
    }
}
