//
//  Coordinator.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func childDidFinish(_ child: Coordinator?)
}
