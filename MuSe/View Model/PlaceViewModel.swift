//
//  PlaceViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 26/04/2022.
//

import Foundation
import UIKit
import CoreData

final class PlaceViewModel {

    // MARK: - Properties

    var coordinator: PlaceCoordinator
    var placeManager: PlaceManager!
    var place: Place

    // MARK: - Initializer

    init(coordinator: PlaceCoordinator, place: Place) {
        self.coordinator = coordinator
        self.place = place
    }

    // MARK: - Methods

    /// Loading Coredata context
    func setup() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)

        history()
    }

    /// Check if the place is in favorites or not
    func updateFavorite() {
        placeManager?.updateFavorite(place)
    }

    /// Mark place as visit for history tab
    func history() {
        placeManager?.updateHistory(place)
    }

    /// to Itinerary
    func itinerary() {
        coordinator.donePlace(with: place)
    }

    /// Go to place's website
    func web() {
        var web = ""

        if place.category == Categories.museum {
            web = "https://" + (place.internet ?? "")
        } else {
            web = place.internet ?? ""
        }

        guard let url = URL(string: web) else { return}
            UIApplication.shared.open(url)
    }
}
