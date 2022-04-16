//
//  MapViewController.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
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
        mapViewModel = MapViewModel(coordinator: coordinator, mapView: mapView, filtersStackView: filtersStackView, selectors: selectors)
        selectedOrNot()
    }

    override func viewDidDisappear(_ animated: Bool) {
        mapViewModel?.viewDidDisappear()
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

    @IBAction func selectorIsTapped(_ sender: CapsuleButton) {
       if sender.isSelected {
            mapViewModel?.removeSelector(tag: sender.tag)
           sender.isSelected = false
        } else {
            mapViewModel?.addSelector(tag: sender.tag)
            sender.isSelected = true
        }
    }
}
