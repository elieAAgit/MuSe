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
    private var placeViewModel: PlaceViewModel?

    @IBOutlet weak var mapLocation: MKMapView!
    @IBOutlet weak var topFavorite: RoundButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var favorite: PlaceButton!
    @IBOutlet weak var adressImage: UIImageView!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var opening: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phone: PlaceButton!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var web: PlaceButton!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionDetail: UITextView!
    @IBOutlet weak var backUp: UILabel!
    @IBOutlet weak var questionMark: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeViewModel = PlaceViewModel(coordinator: coordinator, map: mapLocation, place: place)
        placeViewModel?.setup()
        placeViewModel?.coordinatesSetup()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        favoriteColor()
    }
}

// MARK: - Methods
extension PlaceViewController {
    private func setup() {
        name.text = place.title
        opening.text = place.opening
        phone.setTitle(place.phone, for: .normal)

        validAdress()
        categories()
        openingAndQuestionMark()
        phoneAndInternet()
        favoriteColor()
        description()
    }

    /// Updates favorite when to use
    @IBAction func favoriteTapped(_ sender: Any) {
        placeViewModel?.updateFavorite()
        favoriteColor()
        print("ok")
    }

    /// To itinary view
    @IBAction func itinerary(_ sender: AnimateButton) {
        placeViewModel?.itinerary()
    }

    /// Call the place
    @IBAction func phoneTapped(_ sender: AnimateButton) {
        placeViewModel?.phone()
    }

    /// To the place's website
    @IBAction func webTapped(_ sender: Any) {
        placeViewModel?.web()
    }

    /// Show address if address is valid, otherwise hide address
    private func validAdress() {
        if place.adress != nil && place.adress != "" {
            adress.text = place.adress
        } else {
            adressImage.isHidden = true
            adress.isHidden = true
        }
    }

    /// Show category
    private func categories() {
        categoryImage.image = UIImage(named: place.category?.id ?? "")

        if place.detail != nil && place.detail != "" {
            category.text = place.detail
        } else {
            category.text = place.category?.title
        }
    }

    /// Show favorite's status
    private func favoriteColor() {
        if place.favorite == true {
            topFavorite.tintColor = .yellow
            favorite.tintColor = .yellow
        } else {
            topFavorite.tintColor = .label
            favorite.tintColor = UIColor(named: Colors.capsuleColor.rawValue)
        }
    }

    ///  Hide questionmark if opening is missing
    private func openingAndQuestionMark() {
        if place.opening == nil {
            questionMark.isHidden = true
        }
    }

    /// hide phone and internet if missing
    private func phoneAndInternet() {
        if place.phone == nil {
            phoneView.isHidden = true
        }

        if place.internet == nil {
            webView.isHidden = true
        }
    }

    /// Show description if description is valid
    private func description() {
        if place.descript != nil {
            descriptionDetail.text = place.descript
        } else {
            descriptionTitle.isHidden = true
            descriptionDetail.isHidden = true
        }
    }
}
