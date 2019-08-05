//
//  GoogleMapServiceVC.swift
//  City Guide Demo
//
//  Created by Sherif Darwish on 6/18/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import SwiftyJSON
import Alamofire

class GoogleMapServiceVC: UIViewController,CLLocationManagerDelegate{
    @IBOutlet weak var GMView: GMSMapView!

    var currentLocation = Dictionary<String, Double>()
    let locationManager = CLLocationManager()
    var resultPlace : Result?

    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            print("service on ")
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        getDirections()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = manager.location!.coordinate        
        self.currentLocation = ["lat":locValue.latitude,"long":locValue.longitude]
        setUpMapView()
        showMarker(latitude: currentLocation["lat"]!, longitude: currentLocation["long"]!, title: "Me")
        showMarker(latitude: (self.resultPlace?.geometry?.location?.lat)!, longitude: (self.resultPlace?.geometry?.location?.lng)!, title: (self.resultPlace?.vicinity)!)
        locationManager.stopUpdatingLocation()
    }
    
    func setUpMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: self.currentLocation["lat"]!, longitude: self.currentLocation["long"]!, zoom: 15.0)
        self.GMView.camera = camera
        
    }
    func showMarker(latitude : Double,longitude : Double , title :String){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.map = GMView
    }
    
    
    
    func getDirections() {
        let url = "https://maps.googleapis.com/maps/api/directions/json?"
        let parameters : [String : String] = ["origin" : "\(self.currentLocation["lat"]),\(self.currentLocation["long"])","destination" : "\((self.resultPlace?.geometry?.location?.lat)!),\((self.resultPlace?.geometry?.location?.lng)!)","mode":"driving","key":"AIzaSyDgChPwVs86RFhov7SZwCKNDU27XlBxCRM"]
        Alamofire.request(url, method: .get, parameters: parameters).responseData { (response) in
            if response.result.isSuccess{
                do{
                    let json = try JSON.init(data: response.data!)
                    print(json)
                }catch let error{
                    print("error fetching data \(error.localizedDescription)")
                    
                }
                
            }
        }
    }
}













