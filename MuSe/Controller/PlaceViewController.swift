//
//  PlaceViewController.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
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
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var opening: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phone: PlaceButton!
    @IBOutlet weak var webView: UIView!
    @IBOutlet weak var web: PlaceButton!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionDetail: UITextView!

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
        adress.text = place.adress
        opening.text = place.opening
        phone.setTitle(place.phone, for: .normal)

        categories()
        phoneAndInternet()
        favoriteColor()
        description()
    }

    @IBAction func favoriteTapped(_ sender: Any) {
        placeViewModel?.updateFavorite()
        favoriteColor()
    }

    @IBAction func itinerary(_ sender: AnimateButton) {
        placeViewModel?.itinerary()
    }

    @IBAction func phoneTapped(_ sender: AnimateButton) {
        placeViewModel?.phone()
    }

    @IBAction func webTapped(_ sender: Any) {
        placeViewModel?.web()
    }

    private func categories() {
        categoryImage.image = UIImage(named: place.category?.id ?? "")
        category.text = place.category?.title
    }

    private func favoriteColor() {
        if place.favorite == true {
            topFavorite.tintColor = .yellow
            favorite.tintColor = .yellow
        } else {
            topFavorite.tintColor = .label
            favorite.tintColor = UIColor(named: Colors.capsuleColor.rawValue)
        }
    
    }

    private func phoneAndInternet() {
        if place.phone == nil {
            phoneView.isHidden = true
        }

        if place.internet == nil {
            webView.isHidden = true
        }
    }

    private func description() {
        if place.descript != nil {
            descriptionDetail.text = place.descript
        } else {
            descriptionTitle.isHidden = true
            descriptionDetail.isHidden = true
        }
    }
}
