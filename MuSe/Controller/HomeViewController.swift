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
    
        homeModel = HomeViewModel(coordinator: coordinator)
        homeModel?.setup()
        notifications()
    }

    // MARK: - Method

    private func notifications() {
        NotificationCenter.default.addObserver(self, selector:
            #selector(actionAlert(notification:)), name: .alertName, object: nil)
    }

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
