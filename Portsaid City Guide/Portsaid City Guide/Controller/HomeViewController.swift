//
//  HomeViewController.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/23/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var weatherView: UIVisualEffectView!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var weatherState: UILabel!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    var events:[event] =
        [ event(Name: "Zayed Marathon", photo: #imageLiteral(resourceName: "IMG_8350"), Time: "Tomorrow , 2Pm")
            , event(Name: "Iti event", photo: #imageLiteral(resourceName: "IMG_8351"), Time: "Sunday , 5Pm "),event(Name: "Event3", photo: #imageLiteral(resourceName: "IMG_8350"), Time: "Sunday , 5Pm "),event(Name: "Event4", photo: #imageLiteral(resourceName: "IMG_8350"), Time: "Sunday , 5Pm ")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherView.clipsToBounds = true
        weatherView.layer.cornerRadius = 15
        
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        
        getWeather()
    }

    func getWeather(){
        //let appid = "b6806f231c1d48c1ca000a12b66afb88"
        let url = "https://api.openweathermap.org/data/2.5/weather?"
        let parameters:[String:String] = ["q":"Port Said,EG","appid":"b6806f231c1d48c1ca000a12b66afb88","units":"metric"]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess{
                let data:JSON = JSON(response.result.value!)
                print(data)
                do{
                    let weatherData = try JSONDecoder().decode(WeatherModel.self, from: response.data!)
                    self.maxTemp.text = String(weatherData.main.tempMax)
                    self.minTemp.text = String(weatherData.main.tempMin)
                    self.weatherState.text = weatherData.weather[0].description.capitalized
                    
                }catch let error{
                    print("error --> \( error.localizedDescription)")
                }
            }else{
                print(response.error?.localizedDescription)
            }
            
        }
    }


}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! EventsCollectionViewCell
        cell.updateCell(event: self.events[indexPath.item])
        return cell
    }
    
    
}
