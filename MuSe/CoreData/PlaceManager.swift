//
//  PlaceManager.swift
//  MuSe
//
//  Created by Elie Arquier on 23/04/2022.
//

import Foundation
import CoreData

final class PlaceManager {

    // MARK: - Private Property
    private let entityName = "Place"
    private let context: NSManagedObjectContext

    // MARK: - Initializer
    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - CoreData

    /// To load and updated data in tableView
    var fetchedResultsController: [Place] {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        // Create Fetched Results Controller
        guard let tasks = try? context.fetch(fetchRequest) else { return [] }
                return tasks
    }

    /// Add place in Database
    func addPlace(title: String,
                  detail: String? = nil,
                  category: Category,
                  longitude: Double,
                  latitude: Double,
                  favorite: Bool = false,
                  history: Bool = false,
                  adress: String?,
                  opening: String?,
                  phone: String?,
                  internet: String?,
                  description: String?) {
        let place = Place(context: context)

        // Add data
        place.title = title
        place.detail = detail
        place.category = category
        place.longitude = longitude
        place.latitude = latitude
        place.favorite = favorite
        place.history = history
        place.adress = adress
        place.opening = opening
        place.phone = phone
        place.internet = internet
        place.descript = description

        try? context.save()
    }

    /// Find a specific place in the data base with a name
    func findPlace(_ find: String) -> Place? {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find)

        var place: Place

        if let results = try? context.fetch(request) {
            for result in results {
                place = result

                try? context.save()
                return place
            }
        }

        try? context.save()
        return nil
    }

    /// Find all favorites
    func findPlacesFavorite() -> [Place] {
        findPlaces("favorite")
    }

    /// Finf all history places
    func findPlacesHistory() -> [Place] {
        findPlaces("history")
    }

    /// find place who are history or favorite
    func findPlaces(_ with: String) -> [Place] {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "\(with) == true")

        var places: [Place] = []

        if let results = try? context.fetch(request) {
            for result in results {
                places.append(result)
            }

            try? context.save()
            return places
        } else {
            try? context.save()
            return places
        }
    }

    /// Update favorite
    func updateFavorite(_ find: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find.title!)

        if let results = try? context.fetch(request) {

            for result in results {
                if result.favorite == false && result.latitude == find.latitude && result.longitude == find.longitude {
                    result.favorite = true
                } else if result.favorite == true && result.latitude == find.latitude && result.longitude == find.longitude {
                    result.favorite = false
                }

                try? context.save()
            }
        }
    }

    /// Add place to History
    func updateHistory(_ find: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find.title!)

        if let results = try? context.fetch(request) {

            for result in results {
                if result.history == false && result.latitude == find.latitude && result.longitude == find.longitude {
                    result.history = true
                }

                try? context.save()
            }
        }
    }

    /// Remove history
    func removeFromHistory(_ find: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find.title!)

        if let results = try? context.fetch(request) {

            for result in results {
                if result.history == true && result.latitude == find.latitude && result.longitude == find.longitude {
                    result.history = false
                }

                try? context.save()
            }
        }
    }

    /// Find if a place is a favorite or an history or nothing. Return boolean
    func findPlaceFavoriteOrHistory(title: String, latitude: Double, longitude: Double) -> Bool {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", title)

        if let results = try? context.fetch(request) {

            for result in results {
                if (result.history == true || result.favorite == true) && result.latitude == latitude
                    && result.longitude == longitude {
                    return true
                }

                try? context.save()
                return false
            }
        }

        try? context.save()
        return false
    }

    /// Remove place from the Database
    func removePlace(_ remove: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", remove.title!)

        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }

        try? context.save()
    }

    /// Delete all places from the data base, except favorite and history
    func deleteAll() {
        var objects: [Place] {
            // Create Fetch Request
            let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
            // Configure Fetch Request
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            // Create Fetched Results Controller
            guard let tasks = try? context.fetch(fetchRequest) else { return [] }
                    return tasks
        }

        // Delete multiple objects
        for object in objects {
            if object.history == false && object.favorite == false {
                context.delete(object)
            }

        // Save the deletions to the persistent store
        try? context.save()
        }
    }
}
