//
//  MockNavigationController.swift
//  MuSeTests
//
//  Created by Elie Arquier on 06/12/2023.
//

import Foundation
import XCTest
@testable import MuSe

// Use for create a fake for the initialisation of the coordinators
class MockNavigationController: UINavigationController {
    private var pushedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
