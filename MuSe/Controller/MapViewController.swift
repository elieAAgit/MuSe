//
//  MapViewController.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: MapCoordinator!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filtersStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - Methods
extension MapViewController {
    /// Show or hide map filters
    @IBAction func showFilters(_ sender: CapsuleButton) {
        if filtersStackView.isHidden {
            filtersStackView.isHidden = false
        } else {
            filtersStackView.isHidden = true
        }
    }
}
