//
//  Coordinator.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    // A property to store any child coordinators
    var childCoordinators: [Coordinator] { get set }
    // A property to store the navigation controller that’s being used to present view controllers
    var navigationController: UINavigationController { get set }

    // To make the coordinator take control
    func start()
    func childDidFinish(_ child: Coordinator?)
}
