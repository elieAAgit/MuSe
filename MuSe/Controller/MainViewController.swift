//
//  MainViewController.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
//

import UIKit

class MainViewController: UIViewController, Storyboarded, OtherPageDelegate {

    // MARK: - Property

    weak var coordinator: MainCoordinator?
    private var networkModel = NetworkCallsViewModel()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        networkModel.delegate = self
        networkModel.start()
    }

    func otherPage() {
        self.coordinator?.goToHome()
    }
}
