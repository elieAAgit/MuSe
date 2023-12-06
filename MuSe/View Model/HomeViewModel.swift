//
//  HomeViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 14/04/2022.
//

import UIKit

final class HomeViewModel: NSObject {

    // MARK: - Properties

    private var coordinator: HomeCoordinator

    // The three different categories
    var categories = Categories.categories
    // To select the categories
    var selectors = [String]()

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    let numberOfSections = 1
    var numberOfRows: Int {
        return categories.count
    }

}
// MARK: - Methods
extension HomeViewModel {
    /// Add or remove an item from the selectors.
    func addOrRemoveItem(_ indexPath: Int) {
        let cell = categories[indexPath]

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
    /// Categories selected to be displayed on the map
    func getSelectors() {
        coordinator.getSelectors(with: selectors)
    }
}
