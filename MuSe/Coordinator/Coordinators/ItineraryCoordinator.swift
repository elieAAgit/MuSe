//
//  ItineraryCoordinator.swift
//  MuSe
//
//  Created by Elie Arquier on 19/10/2023.
//

import UIKit

final class ItineraryCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// Configure Place
    func start() {
        let vc = ItineraryViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        nav.configurationNavigation(title: "", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    /// Retrieve data from previous
    func getPlace(with place: Place) {
        let vc = ItineraryViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        vc.place = place
        nav.configurationNavigation(title: place.title ?? "", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    /// Remove the last controller
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {

            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
