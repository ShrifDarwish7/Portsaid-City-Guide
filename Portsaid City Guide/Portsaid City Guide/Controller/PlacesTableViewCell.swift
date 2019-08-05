//
//  PlacesTableViewCell.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/24/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var placePhoto: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAddresse: UILabel!
    @IBOutlet weak var blurContainer: UIVisualEffectView!
    
    func updateCell(image : UIImage , name : String , addresse : String){
        placePhoto.image = image
        placeName.text = name
        placeAddresse.text = addresse
        blurContainer.layer.cornerRadius = 15
        blurContainer.clipsToBounds = true
        placePhoto.layer.cornerRadius = placePhoto.frame.size.width / 2
        placePhoto.clipsToBounds = true
    }

}
