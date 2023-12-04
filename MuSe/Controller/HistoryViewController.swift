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
    private var historyViewModel: HistoryViewModel?

    @IBOutlet weak var missingEntry: RoundedView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.backgroundImage = UIImage()

        historyViewModel = HistoryViewModel(coordinator: coordinator,
                                        tableView: tableView,
                                        searchBar: searchBar,
                                        missingEntry: missingEntry)
        historyViewModel?.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        historyViewModel?.reloadData()
    }
}
