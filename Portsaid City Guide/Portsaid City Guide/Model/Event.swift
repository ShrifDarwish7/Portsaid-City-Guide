//
//  Event.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/23/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

class event{
    
    var name : String!
    var time : String!
    var photo : UIImage?
    
    init(Name : String,photo : UIImage,Time : String){
        
        self.name = Name
        self.photo = photo
        self.time = Time
    }
}
