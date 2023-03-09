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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Cette fonction s'exécute avant l'enclenchement de la Segue
        // Permet de préparer les données à envoyer sur la vue destination
        if segue.identifier == "toMap" {
            let mapVC = segue.destination as! MapViewController
            mapVC.latitude = 47.845665
            mapVC.longitude = 1.939773
        }
    }
    
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
