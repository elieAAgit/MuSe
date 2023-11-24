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

    weak var coordinator: ItineraryCoordinator!
    var place: Place!
    private var itineraryViewModel: ItineraryViewModel?


    @IBOutlet weak var mapLocation: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itineraryViewModel = ItineraryViewModel(coordinator: coordinator, map: mapLocation, place: place)

        itineraryViewModel?.coordinatesSetup()
    }
}
