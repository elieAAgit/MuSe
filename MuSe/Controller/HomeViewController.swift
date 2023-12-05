//
//  HomeViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: HomeCoordinator!
    var homeModel: HomeViewModel?

    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        homeModel = HomeViewModel(coordinator: coordinator, collectionView: homeCollection)
        homeModel?.setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)),
                                               name: .alertName, object: nil)
    }

    // MARK: - Method

    ///  Go to map
    @IBAction func selectCategories(_ sender: AnimateButton) {
        // If no selector selected then show alert
        if homeModel?.selectors.count == 0 {
            Notification.alertNotification(.emptySelectorChoice)
        } else {
            homeModel?.getSelectors()
        }
    }
}
