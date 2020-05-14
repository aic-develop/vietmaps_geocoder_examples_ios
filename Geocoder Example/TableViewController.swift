//
//  TableViewController.swift
//  Example (Swift)
//
//  Created by Phu on 5/13/20.
//  Copyright © 2020 Mapbox. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder

class TableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Geocoder"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)

        // Configure the cell...
        if indexPath.row == 0 {
            cell.textLabel?.text = "Get info location"
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "Search location"
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(ViewController(nibName: nil, bundle: nil), animated: true)
        }
        else if indexPath.row == 1 {
            self.navigationController?.pushViewController(SearchController(nibName: nil, bundle: nil), animated: true)
        }
    }
}
