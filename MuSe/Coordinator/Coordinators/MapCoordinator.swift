//
//  MapCoordinator.swift
//  MuSe
//
//  Created by Qattus on 15/04/2022.
//

import UIKit

final class MapCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// Configure Map
    func start() {
        let vc = MapViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        nav.configurationNavigation(title: "Plan", buttonBack: "Plan")

        navigationController.pushViewController(vc, animated: false)
    }

    /// Retrieve data from home view
    func getSelectors(with selectors: [String]) {
        let vc = MapViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        nav.configurationNavigation(title: "Plan", buttonBack: "Plan")

        navigationController.pushViewController(vc, animated: false)
    }

    func getPlace(with place: Place) {
        let child = PlaceCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.getPlace(with: place)
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