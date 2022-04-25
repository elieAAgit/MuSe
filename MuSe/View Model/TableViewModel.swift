//
//  TableViewModel.swift
//  MuSe
//
//  Created by Qattus on 23/04/2022.
//

import UIKit
import CoreData

final class TableViewModel: NSObject {

    private var coordinator: FavoritesCoordinator?
    private var placeManager: PlaceManager?

    private var searchBar: UISearchBar
    private var tableView: UITableView
    private var missingEntry: RoundedView!
    private var firstLoading: Bool = true

    private var identifierCell = PlaceTableViewCell.cellIdentifier

    init(coordinator: FavoritesCoordinator, tableView: UITableView, searchBar: UISearchBar, missingEntry: RoundedView!) {
        self.coordinator = coordinator
        self.tableView = tableView
        self.missingEntry = missingEntry
        self.searchBar = searchBar
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    
        // To use reusable custom cell
        let nib = UINib(nibName: PlaceTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifierCell)

        let context = AppDelegate.coreDataStack.viewContext
        placeManager = PlaceManager(context: context)

        updateView()
    }

    func reloadData() {
        tableView.reloadData()
        updateView()

        if firstLoading {
            animateTable()
        }
    }
}

// MARK: - Loading and updating view
extension TableViewModel {
    /// Show table view if objects in database > 0, else show indicative message
    private func updateView() {
        var hasEntry = false

        if let entities = placeManager?.findPlaces() {
            hasEntry = entities.count > 0
        }

        tableView.isHidden = !hasEntry
        missingEntry.isHidden = hasEntry
    }
}

extension TableViewModel: UITableViewDelegate, UITableViewDataSource {
    /// Number of sections for the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Number of row for the table view: number of favorites in the database
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entities = placeManager?.fetchedResultsController else { return 0 }

        return entities.count
    }

    /// Display data to the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell)
            as? PlaceTableViewCell else {

            return UITableViewCell()
        }

        // Fetch places
        guard let place = placeManager?.fetchedResultsController[indexPath.row] else { return cell }

        // Pass data to the custom cell
        cell.getInfo(place: place)

        return cell
    }
}

// MARK: - Manage adding and deleting cell in table view
extension TableViewModel: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()

        updateView()
    }

    /// Insert or suppress cell in the table view
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            print("Other case.")
        }
    }
}

// MARK: - Use UITableViewDelegate to access recipe detail
extension TableViewModel {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch places
        guard let place = placeManager?.fetchedResultsController[indexPath.row] else { return }

        // Coordinator to placeViewController
        coordinator?.getPlace(with: place)
    }
}

extension TableViewModel {
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
                }, completion: nil)
            delayCounter += 1
        }

        firstLoading = false
    }
}
