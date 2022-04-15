//
//  HomeViewController.swift
//  MuSe
//
//  Created by Qattus on 12/04/2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: HomeCoordinator!
    private var homeModel: HomeViewModel?
    private var networkModel = NetworkCallsViewModel()

    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        homeModel = HomeViewModel(coordinator: coordinator, collectionView: homeCollection)
        homeModel?.setup()
        networkModel.setup()
    }

    // MARK: - Method

    @IBAction func selectCategories(_ sender: AnimateButton) {
        homeModel?.getSelectors()
    }
}
