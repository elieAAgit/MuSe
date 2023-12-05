//
//  ItineraryViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 19/10/2023.
//

import UIKit
import MapKit

class ItineraryViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: ItineraryCoordinator?
    var place: Place!

    @IBOutlet weak var mapLocation: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coordinatesSetup()
    }

    /// The Coordinates of the place
    func coordinatesSetup() {
        let location = PlaceMap(place: place)
        mapLocation.addAnnotation(location)

        // Set initial location
        let initialLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        mapLocation.centerToLocation(initialLocation)
    }
}
