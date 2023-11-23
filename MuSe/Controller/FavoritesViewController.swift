//
//  FavoritesViewController.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

class FavoritesViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: FavoritesCoordinator!
    private var tableViewModel: TableViewModel?

    @IBOutlet weak var missingEntry: RoundedView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.backgroundImage = UIImage()

        tableViewModel = TableViewModel(coordinator: coordinator,
                                        tableView: tableView,
                                        searchBar: searchBar,
                                        missingEntry: missingEntry)
        tableViewModel?.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableViewModel?.reloadData()
    }
}
