//
//  HistoryCoordinator.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class HistoryCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// ConfigureHistory (with tabBar item)
    func start() {

        let vc = HistoryViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        vc.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "clock.arrow.circlepath"), tag: 2)
        vc.coordinator = self
        nav.configurationNavigation(title: "Historique", buttonBack: "Historique")

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
