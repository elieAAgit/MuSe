//
//  MapViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit
import MapKit

final class MapViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: MapCoordinator!
    private var mapViewModel: MapViewModel?
    var selectors = [String]()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filtersStackView: UIStackView!
    
    @IBOutlet weak var museum: CapsuleButton!
    @IBOutlet weak var theatre: CapsuleButton!
    @IBOutlet weak var library: CapsuleButton!
    @IBOutlet weak var garden: CapsuleButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel = MapViewModel(coordinator: coordinator, mapView: mapView, selectors: selectors)
        mapViewModel?.start()
        selectedOrNot()
    }

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}

// MARK: - Methods
extension MapViewController {
    /// Show or hide map filters
    @IBAction func showFilters(_ sender: CapsuleButton) {
        if filtersStackView.isHidden {
            filtersStackView.isHidden = false
            sender.isSelected = true
        } else {
            filtersStackView.isHidden = true
            sender.isSelected = false
        }
    }

    /// Load the selectors when the page loads
    private func selectedOrNot() {
        for selector in selectors {
            if selector == Categories.museum.id {
                museum.isSelected = true
            } else if selector == Categories.theatre.id {
                theatre.isSelected = true
            } else if selector == Categories.library.id {
                library.isSelected = true
            } else if selector == Categories.garden.id {
                garden.isSelected = true
            }
        }
    }

    ///  Change the status and color of the selectors depending on whether they are selected or not
    @IBAction func selectorIsTapped(_ sender: CapsuleButton) {
        if sender.isSelected {
           if selectors.count > 1 {
               mapViewModel?.removeSelector(tag: sender.tag)
               sender.isSelected = false
           }
        } else {
            mapViewModel?.addSelector(tag: sender.tag)
            sender.isSelected = true
        }

        // Refresh selectors in the MapViewModel
        selectors = mapViewModel?.refreshSelectors() ?? []
    }

    /// Show user location
    @IBAction func userLocation(_ sender: RoundButton) {
        mapViewModel?.getUserLocation()
    }
}
