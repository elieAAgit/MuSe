//
//  TabBarController.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Private Properties

    private let main = MainNavigator(navigationController: UINavigationController())
    private let favorites = FavoritesNavigator(navigationController: UINavigationController())
    private let history = HistoryNavigator(navigationController: UINavigationController())

    private let navigationConfiguration = TabBarAndNavDesign()

    // MARK: - Lifecycle

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
