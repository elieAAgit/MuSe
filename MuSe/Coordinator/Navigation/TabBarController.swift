//
//  TabBarController.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Private Properties

    private let main = MainNavigator(navigationController: UINavigationController())
    private let favorites = FavoritesNavigator(navigationController: UINavigationController())
    private let history = HistoryNavigator(navigationController: UINavigationController())

    private let navigationConfiguration = TabBarAndNavDesign()

    // MARK: - Lifecycle

    // Loading the tabBarController with 1 tab for each navigator
    override func viewDidLoad() {
        super.viewDidLoad()

        main.start()
        favorites.start()
        history.start()

        viewControllers = [main.navigationController,
                           favorites.navigationController,
                           history.navigationController]

        navigationConfiguration.configuration()
    }
}
