//
//  MapViewModel.swift
//  MuSe
//
//  Created by Qattus on 16/04/2022.
//

import UIKit
import MapKit

final class MapViewModel: NSObject {

    // MARK: - Properties

    private var coordinator: MapCoordinator
    private var mapView: MKMapView
    private var filtersStackView: UIStackView
    private var selectors: [String]

    init (coordinator: MapCoordinator, mapView: MKMapView, filtersStackView: UIStackView, selectors: [String]) {
        self.coordinator = coordinator
        self.mapView = mapView
        self.filtersStackView = filtersStackView
        self.selectors = selectors
    }

    func viewDidDisappear() {
        coordinator.refreshSelectors(with: selectors)
    }

    func addSelector(tag: Int) {
        switch tag {
        case 0:
            selectors.append(Categories.museum.id)
        case 1:
            selectors.append(Categories.theatre.id)
        case 2:
            selectors.append(Categories.library.id)
        case 3:
            selectors.append(Categories.garden.id)
        default:
            print("Unknown Selector")
        }

        print(selectors)
    }

    func removeSelector(tag: Int) {
        switch tag {
        case 0:
            selectors.removeAll(where: { $0 == Categories.museum.id })
        case 1:
            selectors.removeAll(where: { $0 == Categories.theatre.id })
        case 2:
            selectors.removeAll(where: { $0 == Categories.library.id })
        case 3:
            selectors.removeAll(where: { $0 == Categories.garden.id })
        default:
            print("Unknown Selector")
        }

        print(selectors)
    }
}

// MARK: - Methods
extension MapViewModel {}
