//
//  TableViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 23/04/2022.
//

import UIKit
import CoreData

final class TableViewModel: NSObject {

    //MARK: - Properties

    private var coordinator: FavoritesCoordinator?
    var placeManager: PlaceManager?

    // Numbers of sections for the table view
    let numbersOfSections = 1

    init(coordinator: FavoritesCoordinator) {
        self.coordinator = coordinator
    }

    /// Prepare the tableView
    func setup() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)
    }
}

// MARK: - Loading and updating view
extension TableViewModel {
    /// Show table view if objects in database > 0, else show indicative message
    func tableHasEntry() -> Bool {
        var hasEntry = false

        if let entities = placeManager?.findPlacesFavorite() {
            hasEntry = entities.count > 0
        }

        return hasEntry
    }

    /// Number of row for the table view: number of histories in the database
    func numberOfRowsInSection() -> Int {
        guard let entities = placeManager?.findPlacesFavorite() else { return 0 }

        return entities.count
    }

    /// Display data to the table view cell
    func dataForCell() -> [Place]? {
        guard let places = placeManager?.findPlacesFavorite() else { return [] }

        return places
    }

    /// Deleting row
    func deletingRow(_ place: Place) {
        // place.favorite = false
        placeManager?.updateFavorite(place)
    }

    func accessToPlace(_ indexPath: Int) {
        var place: Place

        // Fetch places
        guard let places = placeManager?.findPlacesFavorite() else { return }

        place = places[indexPath]

        // Coordinator to placeViewController
        coordinator?.getPlace(with: place)
    }
}
