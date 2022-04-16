//
//  HomeViewModel.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import UIKit

final class HomeViewModel: NSObject {

    // MARK: - Properties

    private var coordinator: HomeCoordinator

    private var collectionView: UICollectionView
    private var categories = Categories.categories
    var selectors = [String]()

    init(coordinator: HomeCoordinator, collectionView: UICollectionView) {
        self.coordinator = coordinator
        self.collectionView = collectionView
    }

    // MARK: - Life Cycle

    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self

        // To use reusable custom cell
        let nib = UINib(nibName: HomeCollectionViewCell.nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: HomeCollectionViewCell.cellIdentifier)
    }

    func refreshSelectors(with selectors: [String]) {
        self.selectors = selectors
    }
}

// MARK: - Collection View
extension HomeViewModel: UICollectionViewDataSource {

    func reloadData() {
        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }

        let category = categories[indexPath.row]
        cell.getCategory(category: category)

        return cell
    }
}

extension HomeViewModel: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = categories[indexPath.row]

        if selectors.contains(cell.id) {
            guard let index = selectors.firstIndex(of: cell.id) else { return }
            selectors.remove(at: index)
        } else {
            selectors.append(cell.id)
        }
    }
}

// MARK: - Coordinator
extension HomeViewModel {

    func getSelectors() {
        if selectors.isEmpty {
            // Show Alert
        } else {
            coordinator.getSelectors(with: selectors)
        }
    }
}
