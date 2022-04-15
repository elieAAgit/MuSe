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

    @IBOutlet weak var mapLocation: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
