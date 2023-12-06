//
//  MapViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: MapCoordinator!
    var mapViewModel: MapViewModel!
    var selectorsForViewModel = [String]()
    lazy var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filtersStackView: UIStackView!
    
    @IBOutlet weak var museum: CapsuleButton!
    @IBOutlet weak var theatre: CapsuleButton!
    @IBOutlet weak var garden: CapsuleButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewModel = MapViewModel(coordinator: coordinator, selectors: selectorsForViewModel)
        mapViewModel.start()
        start()
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

    func start() {
        mapView.delegate = self
        locationManager.delegate = self

        setupMap()
        setupLocationManager()
    }

    /// Load the selectors when the page loads
    private func selectedOrNot() {
        for selector in mapViewModel.selectors {
            if selector == Categories.museum.id {
                museum.isSelected = true
            } else if selector == Categories.theatre.id {
                theatre.isSelected = true
            } else if selector == Categories.garden.id {
                garden.isSelected = true
            }
        }
    }

    ///  Change the status and color of the selectors depending on whether they are selected or not
    @IBAction func selectorIsTapped(_ sender: CapsuleButton) {
        if sender.isSelected {
           if mapViewModel.selectors.count > 1 {
               let value = mapViewModel.removeSelector(tag: sender.tag)
               // Remove all places with this selector
               hideAnnotations(value)
               sender.isSelected = false
           }
        } else {
            let value = mapViewModel.addSelector(tag: sender.tag)
            // Display all places with this selector
            showAnnotations(value)
            sender.isSelected = true
        }
    }
}

// MARK: - MapKit
extension MapViewController: MKMapViewDelegate {
    /// Create the annotations and add to the map
    private func setupMap() {
        mapViewModel.setupPlaces()

        loadingAnnotations()
    }

    /// Display annotations with the new selector
    private func showAnnotations(_ selector: String) {
        for place in mapViewModel.places {
            let location = PlaceMap(place: place)

            guard let placeToAdd = location.place.category?.id else { return }

            if mapViewModel.selectors.contains(placeToAdd) && placeToAdd == selector {
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
        for place in mapViewModel.places {
            let location = PlaceMap(place: place)

            guard let placeToAdd = location.place.category?.id else { return }

            if mapViewModel.selectors.contains(placeToAdd) {
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
        guard let annotation = view.annotation as? PlaceMap else { return }

        mapViewModel.goToPlace(annotation.place)
    }
}

// MARK: - LocationManager
extension MapViewController: CLLocationManagerDelegate {
    /// Show user location
    @IBAction func userLocation(_ sender: RoundButton) {
        getUserLocation()
    }

    /// Setup user location authorization
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        getUserLocation()
    }

    /// Center to the user location
    func getUserLocation() {
        guard let location = mapView.userLocation.location else { return }
        
        mapView.centerToUserLocation(location)
    }

    ///  User location authorization changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
      // 1
      let status = manager.authorizationStatus

      // 2
      mapView.showsUserLocation = (status == .authorizedAlways)
    }
}
