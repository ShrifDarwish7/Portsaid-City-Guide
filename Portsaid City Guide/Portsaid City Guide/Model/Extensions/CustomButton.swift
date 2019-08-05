//
//  CustomButton.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/20/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func setupBtn(label : String){
        
        self.titleLabel?.text = label
        self.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.001759697885, green: 0.6197255711, blue: 0.002730331489, alpha: 1)
        self.layer.cornerRadius = 8
        
    }
    
}
