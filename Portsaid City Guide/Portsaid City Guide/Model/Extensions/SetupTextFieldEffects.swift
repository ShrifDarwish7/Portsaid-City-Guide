//
//  SetupTextFieldEffects.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/20/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

extension HoshiTextField{
    func setUpTextField(placeholder : String){
        self.animateViewsForTextDisplay()
        self.animateViewsForTextEntry()
        self.placeholder = placeholder
        self.borderActiveColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.borderInactiveColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        self.placeholderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.placeholderFontScale = 1
    }
}
