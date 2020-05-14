//
//  SearchController.swift
//  Example (Swift)
//
//  Created by Phu on 5/14/20.
//  Copyright © 2020 Mapbox. All rights reserved.
//

import UIKit
import MapboxGeocoder

class SearchController: UITableViewController, UISearchBarDelegate {
    
    var geocoder: Geocoder!
    var geocodingDataTask: URLSessionDataTask?
    var listResults: [GeocodedPlacemark] = [GeocodedPlacemark]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Enter search text"
        searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchBar
                
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MGLVietMapsAccessToken") as? String
        self.geocoder = Geocoder(accessToken: accessToken)
    }
    
    func searchText(_ text: String) {
        geocodingDataTask?.cancel()
        
        let options = ForwardGeocodeOptions(query: text)
        geocodingDataTask = geocoder.geocode(options) { [unowned self] (placemarks, attribution, error) in
            if let _ = error {
            } else if let placemarks = placemarks, !placemarks.isEmpty {
                self.listResults.removeAll()
                self.listResults.append(contentsOf: placemarks)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let cellData = self.listResults[indexPath.row]
        cell.textLabel?.text = cellData.qualifiedName ?? ""
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let controller = MapController()
        controller.place = self.listResults[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText(searchText)
    }
}
