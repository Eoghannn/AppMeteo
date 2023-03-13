//
//  CityDetailViewController.swift
//  AppMeteo
//
//  Created by tplocal on 13/03/2023.
//

import UIKit
import MapKit

class CityDetailViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!

    var viewModel: CityDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        latitude = viewModel.lat
        longitude = viewModel.lon
        
        let latDelta:CLLocationDegrees = 0.05
        
        let lonDelta:CLLocationDegrees = 0.05
        
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
        
        map.setRegion(region, animated: true)
    }


}
