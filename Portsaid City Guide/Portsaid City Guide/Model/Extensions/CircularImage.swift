//
//  CircularImage.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/21/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func circularImg(image : UIImageView){
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
}
