//
//  HistoryViewController.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

class HistoryViewController: UIViewController, Storyboarded {

    // MARK: - Properties

    weak var coordinator: Coordinator?

    @IBOutlet weak var missingEntry: RoundedView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
