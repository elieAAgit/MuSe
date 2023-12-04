//
//  PlaceCoordinator.swift
//  MuSe
//
//  Created by Elie Arquier on 15/04/2022.
//

import UIKit

final class PlaceCoordinator: Coordinator {

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
        let vc = PlaceViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        nav.configurationNavigation(title: "", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    /// Retrieve data from previous
    func getPlace(with place: Place) {
        let vc = PlaceViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        vc.place = place
        nav.configurationNavigation(title: place.title ?? "", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    func donePlace(with place: Place) {
        let child = ItineraryCoordinator(navigationController: navigationController)
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
