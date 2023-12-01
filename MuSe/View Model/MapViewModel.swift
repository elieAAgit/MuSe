//
//  MapViewModel.swift
//  MuSe
//
//  Created by Qattus on 16/04/2022.
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

    func viewDidDisappear() {
        coordinator.refreshSelectors(with: selectors)
        print(selectors)
    }

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

        showAnnotations(selector)
    }

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

        hideAnnotations(selector)
    }

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

    private func showAnnotations(_ selector: String) {
        for place in places {
            let location = PlaceMap(place: place)

            guard let placeToAdd = location.place.category?.id else { return }

            if selectors.contains(placeToAdd) && placeToAdd == selector {
                mapView.addAnnotation(location)
            }
        }
    }

    private func hideAnnotations(_ selector: String) {
        let annotations = mapView.annotations

        mapView.removeAnnotations(annotations)

        loadingAnnotations()
    }

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

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? PlaceMap else { return }

        coordinator.getPlace(with: place.place)
    }
}

// MARK: - LocationManager
extension MapViewModel: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        getUserLocation()
    }

    func getUserLocation() {
        guard let location = mapView.userLocation.location else { return }
        
        mapView.centerToLocation(location)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      // 1
      let status = manager.authorizationStatus

      // 2
      mapView.showsUserLocation = (status == .authorizedAlways)

      // 3
      if status != .authorizedAlways {
        let message = """
        message
        """

        //showAlert(withTitle: "Warning", message: message)
      }
    }
}
