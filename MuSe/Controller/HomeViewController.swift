//
//  HomeViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 12/04/2022.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: HomeCoordinator!
    var homeModel: HomeViewModel!

    @IBOutlet weak var homeCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // init the viewmodel
        homeModel = HomeViewModel(coordinator: coordinator)
        setup()
        notification()

        // To use reusable custom cell
        let nib = UINib(nibName: HomeCollectionViewCell.nibName, bundle: nil)
        homeCollection.register(nib, forCellWithReuseIdentifier: HomeCollectionViewCell.cellIdentifier)
    }

// MARK: - Method
    /// Collection View Delegate and Datasource
    private func setup() {
        homeCollection.dataSource = self
        homeCollection.delegate = self
    }

    /// Notification for the alert
    private func notification() {
        NotificationCenter.default.addObserver(self, selector: #selector(actionAlert(notification:)),
                                               name: .alertName, object: nil)
    }
}

// MARK: - Collection View
extension HomeViewController: UICollectionViewDataSource {

    /// Reload the collectionView
    func reloadData() {
        homeCollection.reloadData()
    }

    /// Number of sections for the colletion view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeModel.numberOfSections
    }

    /// Number of row for the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModel.numberOfRows
    }

    /// Display data to the collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }

        let category = homeModel.categories[indexPath.row]
        cell.getCategory(category: category)

        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    /// When an item is selected: add or remove from selector
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath = indexPath.row

        homeModel.addOrRemoveItem(indexPath)
    }
}

// MARK: - Coordinator
extension HomeViewController {
    ///  Go to map
    @IBAction func selectCategories(_ sender: AnimateButton) {
        // If no selector selected then show alert
        if homeModel.selectors.count == 0 {
            Notification.alertNotification(.emptySelectorChoice)
        } else {
            homeModel.getSelectors()
        }
    }
}
