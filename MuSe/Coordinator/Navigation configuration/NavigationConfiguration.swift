//
//  NavigationConfiguration.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

final class NavigationConfiguration {

    private let controller: UIViewController

    init(controller: UIViewController) {

        self.controller = controller
    }

    func configurationNavigation(title: String, buttonBack: String, buttonIsHidden: Bool = false) {

        controller.title = title
        controller.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if buttonIsHidden == false {
            let backBarButtonItem = UIBarButtonItem()
            backBarButtonItem.buttonBack(name: buttonBack)
            controller.navigationItem.backBarButtonItem = backBarButtonItem
        } else {
            controller.navigationItem.setHidesBackButton(true, animated: true)
        }
        
    }
}
