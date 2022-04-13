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
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "star.fill"), tag: 1)
        vc.coordinator = self
        nav.configurationNavigation(title: "Favoris", buttonBack: "Favoris")

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
