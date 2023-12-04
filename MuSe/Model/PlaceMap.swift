//
//  PlaceMap.swift
//  MuSe
//
//  Created by Elie Arquier on 16/04/2022.
//

import UIKit
import MapKit
import Contacts

// Custom annotation for the map with custom image for the selected category
class PlaceMap: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var place: Place
    var image: UIImage

    init(place: Place) {
        self.title = place.title
        self.coordinate = CLLocationCoordinate2D(latitude: place.latitude,
                                                 longitude: place.longitude)
        self.place = place
        self.image = UIImage(named: place.category?.id ?? Images.defaultImage.rawValue)!
    }
    
    var subtitle: String? {
        return place.category?.id
    }
}
