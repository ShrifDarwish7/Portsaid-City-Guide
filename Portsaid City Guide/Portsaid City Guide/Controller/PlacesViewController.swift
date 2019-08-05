//
//  PlacesViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/24/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SVProgressHUD
import SwiftyJSON
import GooglePlaces

class PlacesViewController: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var placesTblView: UITableView!
    
    var locationManager = CLLocationManager()
    var currentLocation = Dictionary<String,Double>()
    var resultPlaces : PlaceModel?
    var selectedType : String = ""
    var selectedTypeDefaultImg = UIImage()
    var result : Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        SVProgressHUD.show()

        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            print("service on ")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }else{
            print("service isn`t enable")

        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        self.currentLocation["lat"] = manager.location?.coordinate.latitude
        self.currentLocation["lng"] = manager.location?.coordinate.longitude
        print("My Location ---> \(currentLocation)")
        locationManager.stopUpdatingLocation()
        nearbySearchRequest(lat: currentLocation["lat"]!, lng: currentLocation["lng"]!)
        placesTblView.delegate = self
        placesTblView.dataSource = self
        }
    func nearbySearchRequest(lat : Double,lng : Double){
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        let parameters : [String:String] = ["location":"\(lat),\(lng)","key":"AIzaSyDgChPwVs86RFhov7SZwCKNDU27XlBxCRM","radius":"50000","type":selectedType]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseData { (response) in
            if response.result.isSuccess{
                print("success")
                do{
                    self.resultPlaces = try JSONDecoder().decode(PlaceModel.self, from: response.data!)
                    let temp = try JSON(data: response.data!)
                    print(temp)
                }catch let error{
                    print("JSON Parsing Error \(error)")
                   self.popUpAlert(message: error.localizedDescription)
                }
            }else{
                print("Failed")
                print(response.result.error?.localizedDescription as Any)
            }
            self.placesTblView.reloadData()
            SVProgressHUD.dismiss()
            
        }
    }

}
extension PlacesViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (resultPlaces?.results?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTableViewCell", for: indexPath) as! PlacesTableViewCell
        var placePhoto : UIImage!
        let placeClient = GMSPlacesClient()
        placeClient.fetchPlace(fromPlaceID: (resultPlaces?.results![indexPath.row].id)!, placeFields: .photos, sessionToken: nil, callback: { (place, error) in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let place = place {
                // Get the metadata for the first photo in the place photo metadata list.
                let photoMetadata: GMSPlacePhotoMetadata = place.photos![0]
                
                // Call loadPlacePhoto to display the bitmap and attribution.
                placeClient.loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
                    if let error = error {
                        // TODO: Handle the error.
                        print("Error loading photo metadata: \(error.localizedDescription)")
                        return
                    } else {
                        // Display the first image and its attributions.
                        placePhoto = photo!
                    }
                })
            }
        })
        switch selectedType {
        case "cafe":
            selectedTypeDefaultImg = #imageLiteral(resourceName: "cafe-71")
        case "restaurant":
            selectedTypeDefaultImg = #imageLiteral(resourceName: "restaurant-71")
        case "bank":
            selectedTypeDefaultImg = #imageLiteral(resourceName: "bank_dollar-71")
        case "supermarket":
            selectedTypeDefaultImg = #imageLiteral(resourceName: "supermarket-71")
        case "hospital":
            selectedTypeDefaultImg = #imageLiteral(resourceName: "doctor-71")
        default:
            selectedTypeDefaultImg = #imageLiteral(resourceName: "generic_business-71")
        }
        cell.updateCell(image: placePhoto ?? selectedTypeDefaultImg, name: (resultPlaces?.results![indexPath.row].name)!, addresse: (resultPlaces?.results![indexPath.row].vicinity)!)
        return cell
    
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.result = resultPlaces?.results![indexPath.row]
        performSegue(withIdentifier: "goToPlacesDetailsVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlacesDetailsVC"{
            let nexVC = segue.destination as! PlacesDetailsViewController
            nexVC.resultPlace = result
        }
    }
}







