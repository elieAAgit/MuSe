//
//  ItineraryViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 19/10/2023.
//

import Foundation
import MapKit
import CoreData

final class ItineraryViewModel {

    // MARK: - Properties

    var coordinator: ItineraryCoordinator
    var mapLocation: MKMapView
    var place: Place

    // MARK: - Initializer

    init(coordinator: ItineraryCoordinator, map: MKMapView, place: Place) {
        self.coordinator = coordinator
        self.mapLocation = map
        self.place = place
    }

    // MARK: - Methods

    /// Loading place's coordinates
    func coordinatesSetup() {
        let location = PlaceMap(place: place)
        mapLocation.addAnnotation(location)

        // Set initial location
        let initialLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        mapLocation.centerToLocation(initialLocation)
    }
}
