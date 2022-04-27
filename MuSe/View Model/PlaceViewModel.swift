//
//  PlaceViewModel.swift
//  MuSe
//
//  Created by Qattus on 26/04/2022.
//

import Foundation
import MapKit
import CoreData

final class PlaceViewModel {

    // MARK: - Properties

    var coordinator: PlaceCoordinator
    var placeManager: PlaceManager!
    var mapLocation: MKMapView
    var place: Place

    // MARK: - Initializer

    init(coordinator: PlaceCoordinator, map: MKMapView, place: Place) {
        self.coordinator = coordinator
        self.mapLocation = map
        self.place = place
    }

    // MARK: - Methods

    /// Loading Coredata context
    func setup() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)
    }

    /// Loading place's coordinates
    func coordinatesSetup() {
        let location = PlaceMap(place: place)
        mapLocation.addAnnotation(location)

        // Set initial location
        let initialLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        mapLocation.centerToLocation(initialLocation)
    }

    /// Check if the place is in favorites or not
    func updateFavorite() {
        placeManager?.updateFavorite(place)
    }

    func itinerary() {}

    /// Call place
    func phone() {
        if let callUrl = URL(string: "tel:\(String(describing: place.phone))"), UIApplication.shared.canOpenURL(callUrl) {
            UIApplication.shared.open(callUrl)
        }
    }

    /// Go to place's website
    func web() {
        guard let url = URL(string: place.internet ?? "") else { return}
            UIApplication.shared.open(url)
    }
}
