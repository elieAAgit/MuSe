//
//  NavigationConfiguration.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

final class NavigationConfiguration {

    private let controller: UIViewController

    init(controller: UIViewController) {

        self.controller = controller
    }

    /// Give a title, a return button or not, and give a name to the button or not
    func configurationNavigation(title: String, buttonBack: String, buttonIsHidden: Bool = false) {

        // Title
        controller.title = title
        controller.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let backBarButtonItem = UIBarButtonItem()
        // Back button name
        backBarButtonItem.buttonBack(name: buttonBack)
        controller.navigationItem.backBarButtonItem = backBarButtonItem
        
        // hide back button
        if buttonIsHidden == true {
            controller.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
}
