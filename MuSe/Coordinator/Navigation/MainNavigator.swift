//
//  MainNavigator.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import Foundation
import UIKit

final class MainNavigator: NSObject, Coordinator, UINavigationControllerDelegate {

    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    /// To launch Main
    func start() {
        navigationController.delegate = self

        let child = MainCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }

    /// Removing controllers
    func navigationController(_ navigationController: UINavigationController,
                              didShow ViewController: UIViewController, animated: Bool) {

        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }

        if navigationController.viewControllers.contains(fromViewController) { return }

        // ControllerViewController: the name of your controller
        if let mainViewController = fromViewController as? MainViewController {
            childDidFinish(mainViewController.coordinator)
        }

        if let homeViewController = fromViewController as? HomeViewController {
            childDidFinish(homeViewController.coordinator)
        }

        if let mapViewController = fromViewController as? MapViewController {
            childDidFinish(mapViewController.coordinator)
        }

        if let placeViewController = fromViewController as? PlaceViewController {
            childDidFinish(placeViewController.coordinator)
        }

        if let itineraryViewController = fromViewController as? ItineraryViewController {
            childDidFinish(itineraryViewController.coordinator)
        }
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
