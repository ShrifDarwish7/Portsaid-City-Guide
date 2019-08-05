//
//  PopUpAlert.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/21/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func popUpAlert(message : String){
        let alert = UIAlertController.init(title: "Failed", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
