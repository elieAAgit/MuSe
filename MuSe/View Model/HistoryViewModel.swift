//
//  HistoryViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 18/11/2023.
//

import UIKit
import CoreData

final class HistoryViewModel: NSObject {

    //MARK: - Properties

    private var coordinator: HistoryCoordinator?
    var placeManager: PlaceManager?

    // Numbers of sections for the table view
    let numbersOfSections = 1

    init(coordinator: HistoryCoordinator) {
        self.coordinator = coordinator
    }

    /// Prepare the tableView
    func setup() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)
    }
}

// MARK: - Loading and updating view
extension HistoryViewModel {
    /// Show table view if objects in database > 0, else show indicative message
    func tableHasEntry() -> Bool {
        var hasEntry = false

        if let entities = placeManager?.findPlacesHistory() {
            hasEntry = entities.count > 0
        }

        return hasEntry
    }

    /// Number of row for the table view: number of histories in the database
    func numberOfRowsInSection() -> Int {
        guard let entities = placeManager?.findPlacesHistory() else { return 0 }

        return entities.count
    }

    /// Display data to the table view cell
    func dataForCell() -> [Place]? {
        guard let places = placeManager?.findPlacesHistory() else { return [] }

        return places
    }

    /// Deleting row
    func deletingRow(_ place: Place) {
        // place.history = false
        placeManager?.removeFromHistory(place)
    }

    func accessToPlace(_ indexPath: Int) {
        var place: Place

        // Fetch places
        guard let places = placeManager?.findPlacesHistory() else { return }

        place = places[indexPath]

        // Coordinator to placeViewController
        coordinator?.getPlace(with: place)
    }
}
