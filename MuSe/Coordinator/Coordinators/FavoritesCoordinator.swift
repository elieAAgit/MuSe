//
//  FavoritesCoordinator.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class FavoritesCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// Configure Favorites (with tabBar item)
    func start() {

        let vc = FavoritesViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        nav.configurationNavigation(title: "Favoris", buttonBack: "")
        vc.tabBarItem = UITabBarItem(title: "Favoris", image: UIImage(systemName: "star.fill"), tag: 1)
        vc.coordinator = self

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
