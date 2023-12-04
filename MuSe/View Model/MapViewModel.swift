//
//  MapViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 16/04/2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

final class MapViewModel: NSObject {

    // MARK: - Properties

    private var coordinator: MapCoordinator
    private var mapView: MKMapView
    private var selectors: [String]
    private var placeManager: PlaceManager!
    private var places = [Place]()
    lazy var locationManager = CLLocationManager()

    init (coordinator: MapCoordinator, mapView: MKMapView, selectors: [String]) {
        self.coordinator = coordinator
        self.mapView = mapView
        self.selectors = selectors
    }

    // MARK: - Methods

    func start() {
        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)

        mapView.delegate = self
        locationManager.delegate = self

        setupMap()
        setupLocationManager()
    }

    /// Add 1 selector to selectors and map
    func addSelector(tag: Int) {
        var selector: String {
            switch tag {
            case 0:
                selectors.append(Categories.museum.id)
                return Categories.museum.id
            case 1:
                selectors.append(Categories.theatre.id)
                return Categories.theatre.id
            case 2:
                selectors.append(Categories.library.id)
                return Categories.library.id
            case 3:
                selectors.append(Categories.garden.id)
                return Categories.garden.id
            default:
                print("Unknown Selector")
                return "Unknown"
            }
        }

        // Display all places with this selector
        showAnnotations(selector)
    }

    /// Remove 1 selector to selectors and the map
    func removeSelector(tag: Int) {
        var selector: String {
            switch tag {
            case 0:
                selectors.removeAll(where: { $0 == Categories.museum.id })
                return Categories.museum.id
            case 1:
                selectors.removeAll(where: { $0 == Categories.theatre.id })
                return Categories.theatre.id
            case 2:
                selectors.removeAll(where: { $0 == Categories.library.id })
                return Categories.library.id
            case 3:
                selectors.removeAll(where: { $0 == Categories.garden.id })
                return Categories.garden.id
            default:
                print("Unknown Selector")
                return "Unknown"
            }
        }

        // Remove all places with this selector
        hideAnnotations(selector)
    }

    /// Adding or removing a selector from selectors when a selector is tapped on MapViewController
    func refreshSelectors() -> [String] {
        let value = selectors

        return value
    }
}

// MARK: - MapKit
extension MapViewModel: MKMapViewDelegate {
    /// Create the annotations and add to the map
    private func setupMap() {
        places = placeManager.fetchedResultsController

        loadingAnnotations()
    }

    /// Display annotations with the new selector
    private func showAnnotations(_ selector: String) {
        for place in places {
            let location = PlaceMap(place: place)

            guard let placeToAdd = location.place.category?.id else { return }

            if selectors.contains(placeToAdd) && placeToAdd == selector {
                mapView.addAnnotation(location)
            }
        }
    }

    /// Remove all annotations with the selector
    private func hideAnnotations(_ selector: String) {
        let annotations = mapView.annotations

        mapView.removeAnnotations(annotations)

        loadingAnnotations()
    }

    /// Load more than 1 selector, and display to the map
    private func loadingAnnotations() {
        for place in places {
            let location = PlaceMap(place: place)

            guard let placeToAdd = location.place.category?.id else { return }

            if selectors.contains(placeToAdd) {
                mapView.addAnnotation(location)
            }
        }

    }

    /// Create annotationView with custom pin for different categories
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is PlaceMap else { return nil }

        let identifier = "PlaceMapLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        guard annotationView != nil else {
            annotationView = PlaceView(annotation: annotation, reuseIdentifier: identifier)

            return annotationView
        }
        annotationView?.annotation = annotation

        return annotationView
    }

    ///  Go to place details
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? PlaceMap else { return }

        coordinator.getPlace(with: place.place)
    }
}

// MARK: - LocationManager
extension MapViewModel: CLLocationManagerDelegate {
    /// Setup user location authorization
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        getUserLocation()
    }

    /// Center to the user location
    func getUserLocation() {
        guard let location = mapView.userLocation.location else { return }
        
        mapView.centerToLocation(location)
    }

    ///  User location authorization changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      // 1
      let status = manager.authorizationStatus

      // 2
      mapView.showsUserLocation = (status == .authorizedAlways)
    }
}
