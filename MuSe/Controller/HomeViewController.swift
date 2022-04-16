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
    var homeModel: HomeViewModel?
    private var networkModel = NetworkCallsViewModel()

    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        homeModel = HomeViewModel(coordinator: coordinator, collectionView: homeCollection)
        homeModel?.setup()
        networkModel.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        homeModel?.reloadData()
    }

    // MARK: - Method

    @IBAction func selectCategories(_ sender: AnimateButton) {
        homeModel?.getSelectors()
    }

    func refreshSelectors(with selectors: [String]) {
        homeModel?.refreshSelectors(with: selectors)
    }
}
