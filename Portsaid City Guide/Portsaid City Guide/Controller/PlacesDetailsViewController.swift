//
//  PlacesDetailsViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/27/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import GooglePlaces

class PlacesDetailsViewController: UIViewController {

    var resultPlace : Result?

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var placeAddresse: UITextField!
    
    let placeClient = GMSPlacesClient()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        placeName.text = resultPlace?.name
        placeAddresse.text = resultPlace?.vicinity
        rate.text = "\(resultPlace?.rating ?? 4.0)"
        
        placeClient.fetchPlace(fromPlaceID: (resultPlace?.id)!, placeFields: .photos, sessionToken: nil, callback: { (place, error) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let place = place {
                // Get the metadata for the first photo in the place photo metadata list.
                let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
                
                // Call loadPlacePhoto to display the bitmap and attribution.
                self.placeClient.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                    if let error = error {
                        // TODO: Handle the error.
                        print("Error loading photo metadata: \(error.localizedDescription)")
                        return
                    } else {
                        // Display the first image and its attributions.
                        self.placeImg.image = photo!
                    }
                })
            }
        })
    }

    @IBAction func onMapClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMap", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMap" {
            let nextVC = segue.destination as! GoogleMapServiceVC
            nextVC.resultPlace = self.resultPlace
        }
    }
}
