//
//  AutoCompleteViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/28/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacesSearchController

class AutoCompleteViewController: UIViewController {

    @IBOutlet weak var GMSMapView: GMSMapView!
    @IBOutlet weak var search: UIBarButtonItem!
    
    var controller : GooglePlacesSearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        controller = GooglePlacesSearchController.init(delegate: self, apiKey: "AIzaSyDgChPwVs86RFhov7SZwCKNDU27XlBxCRM")
        let camera = GMSCameraPosition.init(latitude: 31.2653, longitude: 32.3019, zoom: 15)
        GMSMapView.camera = camera
    }
    
    @IBAction func searchClicked(_ sender: UIBarButtonItem) {
        present(controller!, animated: true, completion: nil)
    }
    func createMarker(coordinates : CLLocationCoordinate2D , title : String , snippet : String){
            let marker = GMSMarker.init(position: coordinates)
            marker.title = title
            marker.snippet = snippet
            marker.map = self.GMSMapView
            let camera = GMSCameraPosition.init(target: coordinates, zoom: 15)
            self.GMSMapView.camera = camera
        }

    }
    extension AutoCompleteViewController:GooglePlacesAutocompleteViewControllerDelegate{
        func viewController(didAutocompleteWith place: PlaceDetails) {
            dismiss(animated: true) {
                self.createMarker(coordinates : place.coordinate! , title : place.name! , snippet : place.description)
            }
        }
        
    }


