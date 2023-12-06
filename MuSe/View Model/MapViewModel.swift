//
//  MapViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 16/04/2022.
//

import UIKit
import CoreData

final class MapViewModel: NSObject {

    // MARK: - Properties

    private var coordinator: MapCoordinator
    private var placeManager: PlaceManager!
    var places = [Place]()
    var selectors = [String]()

    init (coordinator: MapCoordinator, selectors: [String]) {
        self.coordinator = coordinator
        self.selectors = selectors
    }

    // MARK: - Methods

    func start() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)
    }

    func setupPlaces() {
        places = placeManager.fetchedResultsController
    }

    /// Add 1 selector to selectors and map
    func addSelector(tag: Int) -> String {
        var selector: String {
            switch tag {
            case 0:
                selectors.append(Categories.museum.id)
                return Categories.museum.id
            case 1:
                selectors.append(Categories.theatre.id)
                return Categories.theatre.id
            case 2:
                selectors.append(Categories.garden.id)
                return Categories.garden.id
            default:
                print("Unknown Selector")
                return "Unknown"
            }
        }
        return selector
    }

    /// Remove 1 selector to selectors and the map
    func removeSelector(tag: Int) -> String {
        var selector: String {
            switch tag {
            case 0:
                selectors.removeAll(where: { $0 == Categories.museum.id })
                return Categories.museum.id
            case 1:
                selectors.removeAll(where: { $0 == Categories.theatre.id })
                return Categories.theatre.id
            case 2:
                selectors.removeAll(where: { $0 == Categories.garden.id })
                return Categories.garden.id
            default:
                print("Unknown Selector")
                return "Unknown"
            }
        }
        return selector
    }

    func goToPlace(_ place: Place) {
        coordinator.getPlace(with: place)
    }
}
