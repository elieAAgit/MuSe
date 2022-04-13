//
//  MainViewController.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
//

import UIKit

class MainViewController: UIViewController, Storyboarded {

    // MARK: - Property

    weak var coordinator: MainCoordinator?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

// MARK: - Method

extension MainViewController {
    @IBAction func tapped(_ sender: UIButton) {
        coordinator?.goToHome()
    }
}
