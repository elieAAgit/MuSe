//
//  PlaceView.swift
//  MuSe
//
//  Created by Elie Arquier on 22/04/2022.
//

import MapKit

// Creation of a personalized annotation displaying a precise image depending on the chosen category
final class PlaceView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
        if let place = newValue as? PlaceMap {
            clusteringIdentifier = "PlaceMap"
            image = place.image
        }

        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
}
