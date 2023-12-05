//
//  MKMapView.swift
//  MuSe
//
//  Created by Elie Arquier on 22/04/2022.
//

import MapKit

extension MKMapView {
    /// Center the map 
    func centerToLocation(_ location: CLLocation,
                        regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }

    func centerToUserLocation(_ location: CLLocation,
                              regionRadius: CLLocationDistance = 100) {
              let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                        latitudinalMeters: regionRadius,
                                                        longitudinalMeters: regionRadius)
              
              setRegion(coordinateRegion, animated: true)
    }
}
