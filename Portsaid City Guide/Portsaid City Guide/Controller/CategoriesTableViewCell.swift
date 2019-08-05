//
//  CategoriesTableViewCell.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/23/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func updateCell(category : Categories){
        img.image = category.image
        title.text = category.title
    }

}
