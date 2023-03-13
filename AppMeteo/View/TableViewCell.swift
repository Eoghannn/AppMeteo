//
//  TableViewCell.swift
//  AppMeteo
//
//  Created by tplocal on 09/03/2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var villeLabel: UILabel!
    
    func setCellWithValuesOf(_ city: CityEntity) {
        updateUI(name: city.name!, country: city.country!)
    }
    
    private func updateUI(name:String, country:String) {
        self.villeLabel.text = "\(name), \(country)"

    }

}
