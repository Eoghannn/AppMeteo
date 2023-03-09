//
//  VillesController.swift
//  AppMeteo
//
//  Created by tplocal on 08/03/2023.
//

import UIKit

class VillesController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var headlines = ["Orléans", "Paris", "Londres"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        navigationItem.searchController = search
    }

    @IBOutlet var villes: UITableView!
    
}

extension VillesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ville", for: indexPath) as! TableViewCell

        let headline = headlines[indexPath.row]
        cell.villeLabel.text = headline
        return cell
    }

}
