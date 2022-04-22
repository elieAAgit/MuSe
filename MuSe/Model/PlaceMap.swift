//
//  PlaceMap.swift
//  MuSe
//
//  Created by Qattus on 16/04/2022.
//

import UIKit
import MapKit
import Contacts

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
        self.image = UIImage(named: place.category.id) ?? UIImage(named: "Default")!
    }

    
    var subtitle: String? {
        return place.category.id
    }
/*
    var mapItem: MKMapItem? {
        guard let location = title else {
        return nil
      }

      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(
        coordinate: coordinate,
        addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
*/
}
