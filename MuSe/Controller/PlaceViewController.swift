//
//  PlaceViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit
import MapKit

class PlaceViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: PlaceCoordinator!
    var place: Place!
    var placeModel: PlaceViewModel!

    @IBOutlet weak var mapLocation: MKMapView!
    @IBOutlet weak var topFavorite: RoundButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var favorite: PlaceButton!
    @IBOutlet weak var adressImage: UIImageView!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var opening: UILabel!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var web: PlaceButton!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionDetail: UITextView!
    @IBOutlet weak var backUp: UILabel!
    @IBOutlet weak var questionMark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeModel = PlaceViewModel(coordinator: coordinator, place: place)
        placeModel.setup()

        coordinatesSetup()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        favoriteColor()
    }
}

// MARK: - Map
extension PlaceViewController{
    /// Loading place's coordinates
    func coordinatesSetup() {
        let thisPlace = placeModel.place
        let location = PlaceMap(place: thisPlace)
        mapLocation.addAnnotation(location)

        // Set initial location
        let latitude = thisPlace.latitude
        let longitude = thisPlace.longitude
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)

        mapLocation.centerToLocation(initialLocation)
    }
}

// MARK: - Methods
extension PlaceViewController {
    private func setup() {
        name.text = placeModel.place.title
        opening.text = placeModel.place.opening


        validAdress()
        categories()
        openingAndQuestionMark()
        showInternet()
        favoriteColor()
        description()
    }

    /// Updates favorite when to use
    @IBAction func favoriteTapped(_ sender: Any) {
        placeModel.updateFavorite()
        favoriteColor()
        print("ok")
    }

    /// To itinary view
    @IBAction func itinerary(_ sender: AnimateButton) {
        placeModel.itinerary()
    }

    /// To the place's website
    @IBAction func webTapped(_ sender: Any) {
        placeModel.web()
    }

    /// Show address if address is valid, otherwise hide address
    private func validAdress() {
        if placeModel.place.adress != nil && placeModel.place.adress != "" {
            adress.text = placeModel.place.adress
        } else {
            adressImage.isHidden = true
            adress.isHidden = true
        }
    }

    /// Show category
    private func categories() {
        let named = placeModel.place.category?.id ?? ""
        categoryImage.image = UIImage(named: named)

        if placeModel.place.detail != nil && placeModel.place.detail != "" {
            category.text = placeModel.place.detail
        } else {
            category.text = placeModel.place.category?.title
        }
    }

    /// Show favorite's status
    private func favoriteColor() {
        if placeModel.place.favorite == true {
            topFavorite.tintColor = .yellow
            favorite.tintColor = .yellow
        } else {
            topFavorite.tintColor = .label
            favorite.tintColor = UIColor(named: Colors.capsuleColor.rawValue)
        }
    }

    ///  Hide questionmark if opening is missing
    private func openingAndQuestionMark() {
        if placeModel.place.opening == nil {
            questionMark.isHidden = true
        }
    }

    /// hide phone and internet if missing
    private func showInternet() {
        if placeModel.place.internet == nil {
            webView.isHidden = true
        }
    }

    /// Show description if description is valid
    private func description() {
        if placeModel.place.descript != nil {
            descriptionDetail.text = placeModel.place.descript
        } else {
            descriptionTitle.isHidden = true
            descriptionDetail.isHidden = true
        }
    }
}
