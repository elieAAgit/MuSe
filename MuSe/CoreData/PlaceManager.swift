//
//  PlaceManager.swift
//  MuSe
//
//  Created by Qattus on 23/04/2022.
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

    ///
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

    ///
    func findPlacesFavorite() -> [Place] {
        findPlaces("favorite")
    }

    func findPlacesHistory() -> [Place] {
        findPlaces("history")
    }

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
                if result.favorite == false {
                    result.favorite = true
                } else if result.favorite == true {
                    result.favorite = false
                }

                try? context.save()
            }
        }
    }

    /// Update favorite
    func updateHistory(_ find: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find.title!)

        if let results = try? context.fetch(request) {

            for result in results {
                if result.history == false {
                    result.history = true
                }

                try? context.save()
            }
        }
    }

    func removeFromHistory(_ find: Place) {
        let request: NSFetchRequest<Place> = Place.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", find.title!)

        if let results = try? context.fetch(request) {

            for result in results {
                if result.history == true {
                    result.history = false
                }

                try? context.save()
            }
        }
    }
    
    /// Remove place in Database
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

    func deleteAll() {
        // Specify a batch to delete with a fetch request
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: entityName)

        // Create a batch delete request for the
        // fetch request
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest
        )

        // Specify the result of the NSBatchDeleteRequest
        // should be the NSManagedObject IDs for the
        // deleted objects
        deleteRequest.resultType = .resultTypeObjectIDs

        // Perform the batch delete
        let batchDelete = try? context.execute(deleteRequest)
            as? NSBatchDeleteResult

        guard let deleteResult = batchDelete?.result
            as? [NSManagedObjectID]
            else { return }

        let deletedObjects: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deleteResult
        ]

        // Merge the delete changes into the managed
        // object context
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [context]
        )
    }
}
