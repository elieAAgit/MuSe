//
//  HistoryViewController.swift
//  MuSe
//
//  Created by Elie Arquier on 13/04/2022.
//

import UIKit

class HistoryViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: HistoryCoordinator!
    private var historyViewModel: HistoryViewModel!

    @IBOutlet weak var missingEntry: RoundedView!
    @IBOutlet weak var tableView: UITableView!

    // Cell identifier
    private var identifierCell = PlaceTableViewCell.cellIdentifier
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the model
        historyViewModel = HistoryViewModel(coordinator: coordinator)
        historyViewModel.setup()

        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }

    //MARK: - Methods

    /// Prepare the tableView
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self

        // To use reusable custom cell
        let nib = UINib(nibName: PlaceTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifierCell)

        updateView()
    }

    /// Reloading data when view will appear
    func reloadData() {
        tableView.reloadData()
        updateView()
    }

    /// Show table view if objects in database > 0, else show indicative message
    private func updateView() {
        let hasEntry = historyViewModel.tableHasEntry()

        tableView.isHidden = !hasEntry
        missingEntry.isHidden = hasEntry
    }
}

// MARK: - The Table View
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    /// Number of sections for the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return historyViewModel.numbersOfSections
    }

    /// Number of row for the table view: number of histories in the database
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewModel.numberOfRowsInSection()
    }

    /// Display data to the table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell)
            as? PlaceTableViewCell else {

            return UITableViewCell()
        }
        var place: Place

        // Fetch places
        guard let places = historyViewModel.dataForCell() else { return cell }

        place = places[indexPath.row]

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
            self.historyViewModel.deletingRow(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }

    /// Access place detail
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyViewModel.accessToPlace(indexPath.row)
    }
}
