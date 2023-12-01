//
//  HomeCoordinator.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import UIKit

final class HomeCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// Configure Home
    func start() {
        let vc = HomeViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        nav.configurationNavigation(title: "", buttonBack: "", buttonIsHidden: true)
        vc.coordinator = self

        navigationController.pushViewController(vc, animated: false)
    }

    /// Go to map view
    func getSelectors(with selectors: [String]) {
        let child = MapCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.getSelectors(with: selectors)
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
