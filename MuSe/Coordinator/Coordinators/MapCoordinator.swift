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
        nav.configurationNavigation(title: "Plan", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    /// Retrieve data from home view
    func getSelectors(with selectors: [String]) {
        let vc = MapViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.coordinator = self
        vc.selectors = selectors
        nav.configurationNavigation(title: "Plan", buttonBack: "")

        navigationController.pushViewController(vc, animated: false)
    }

    func refreshSelectors(with selectors: [String]) {
        guard let vc = navigationController.viewControllers.last as? HomeViewController else { return }
    
        vc.refreshSelectors(with: selectors)
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
