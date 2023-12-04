//
//  HistoryViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 18/11/2023.
//

import UIKit
import CoreData

final class HistoryViewModel: NSObject {

    private var coordinator: HistoryCoordinator?
    private var placeManager: PlaceManager?

    private var searchBar: UISearchBar
    private var tableView: UITableView
    private var missingEntry: RoundedView!

    // properties use with searBar for filtering results of search
    private var filtered: [String] = []
    private var isFiltering = false

    private var identifierCell = PlaceTableViewCell.cellIdentifier

    init(coordinator: HistoryCoordinator, tableView: UITableView, searchBar: UISearchBar, missingEntry: RoundedView!) {
        self.coordinator = coordinator
        self.tableView = tableView
        self.missingEntry = missingEntry
        self.searchBar = searchBar
    }

    /// Prepare the tableView
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

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
    }
}

// MARK: - Loading and updating view
extension HistoryViewModel {
    /// Show table view if objects in database > 0, else show indicative message
    private func updateView() {
        var hasEntry = false

        if let entities = placeManager?.findPlacesHistory() {
            hasEntry = entities.count > 0
        }

        tableView.isHidden = !hasEntry
        missingEntry.isHidden = hasEntry
    }
}

extension HistoryViewModel: UITableViewDelegate, UITableViewDataSource {
    /// Number of sections for the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /// Number of row for the table view: number of histories in the database
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let entities = placeManager?.findPlacesHistory() else { return 0 }

        if isFiltering {

            return filtered.count
        } else {

            return entities.count
        }
    }

    /// Display data to the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell)
            as? PlaceTableViewCell else {

            return UITableViewCell()
        }

        var place: Place

        if isFiltering {
            let title = filtered[indexPath.row]
            guard let value = placeManager?.findPlace(title) else { return cell }

            place = value
        } else {
            // Fetch places
            guard let places = placeManager?.findPlacesHistory() else { return cell }

            place = places[indexPath.row]
        }

        // Pass data to the custom cell
        cell.getInfo(place: place)

        return cell
    }

    /// Deleting row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let cell = tableView.cellForRow(at: indexPath) as? PlaceTableViewCell

            guard let place = cell?.place else { return }

            // place.history = false
            self.placeManager?.removeFromHistory(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Manage adding and deleting cell in table view
extension HistoryViewModel: NSFetchedResultsControllerDelegate {
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
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            print("Other case.")
        }
    }
}

// MARK: - Use UITableViewDelegate to access place detail
extension HistoryViewModel {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var place: Place

        if isFiltering {
            let title = filtered[indexPath.row]
            guard let value = placeManager?.findPlace(title) else { return }

            place = value
        } else {
            // Fetch places
            guard let places = placeManager?.findPlacesHistory() else { return }

            place = places[indexPath.row]
        }

        // Coordinator to placeViewController
        coordinator?.getPlace(with: place)
    }
}

// MARK: - SearchBar
extension HistoryViewModel: UISearchBarDelegate {
    /// Preparation of filtering in the searchbar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let places = placeManager?.findPlacesHistory()
        var table = [String]()
        
        for place in places! {
            table.append(place.title!)
        }
        
        filtered = table.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased() })
            isFiltering = true
            tableView.reloadData()
    }
}

// MARK: - Keyboard
extension HistoryViewModel {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()

        return true
    }
}
