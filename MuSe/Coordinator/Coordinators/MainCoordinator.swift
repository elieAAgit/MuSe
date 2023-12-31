//
//  MainCoordinator.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

final class MainCoordinator: Coordinator {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// Configure Main (with tabBar item)
    func start() {
        let vc = MainViewController.instantiate()
        let nav = NavigationConfiguration(controller: vc)
        nav.configurationNavigation(title: "", buttonBack: "")
        vc.tabBarItem = UITabBarItem(title: "lieux", image: UIImage(systemName: "house.fill"), tag: 0)

        vc.coordinator = self

        navigationController.pushViewController(vc, animated: false)
    }

    /// Go to home view
    func goToHome() {
        let child = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
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
