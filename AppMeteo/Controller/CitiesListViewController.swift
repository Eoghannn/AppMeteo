//
//  CitiesListViewController.swift
//  AppMeteo
//
//  Created by tplocal on 13/03/2023.
//

import UIKit
import CoreData

class CitiesListViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UpdateTableViewDelegate {
        
    private var viewModel = CitiesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        navigationItem.searchController = search
        search.searchBar.showsScopeBar = true

        setNavigationBar()
        self.tableView.dataSource = self
        self.viewModel.delegate = self
        loadData()
    }
    
    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }
    
    // Update the tableView if changes have been made
    func reloadData(sender: CitiesListViewModel) {
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation - a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "citySelected" {
            guard let weatherVC = segue.destination as? CityDetailViewController else {return}
            guard let selectedCityCell = sender as? UITableViewCell else {return}
            
            if let indexPath = tableView.indexPath(for: selectedCityCell) {
                let selectedCity = viewModel.object(indexPath: indexPath)
                weatherVC.viewModel = CityDetailViewModel(city: selectedCity)
            }
            // Back button without title on the next screen
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    //MARK: - Navigation Bar appearance
    private func setNavigationBar() {
        // Transparent the navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Navigation bar item color (time, battery) - white
        self.navigationController?.navigationBar.barStyle = .black
    }
}

//MARK: - TableView
extension CitiesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        
        let object = viewModel.object(indexPath: indexPath)
        
        if let cityCell = cell as? TableViewCell {
            if let city = object {
                cityCell.setCellWithValuesOf(city)
            }
        }
        return cell
    }
}
