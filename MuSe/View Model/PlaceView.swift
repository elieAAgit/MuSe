//
//  PlaceView.swift
//  MuSe
//
//  Created by Qattus on 22/04/2022.
//

import MapKit

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
