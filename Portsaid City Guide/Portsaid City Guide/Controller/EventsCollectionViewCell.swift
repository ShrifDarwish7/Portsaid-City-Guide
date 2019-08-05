//
//  EventsCollectionViewCell.swift
//  Portsaid City Guide
//
//  Created by Sherif Darwish on 7/23/19.
//  Copyright © 2019 Sherif Darwish. All rights reserved.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var blurContainer: UIVisualEffectView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    func updateCell(event : event){
        self.eventName.text = event.name
        self.eventTime.text = event.time
        self.eventImage.image = event.photo
        self.RoundFrameOnly(self.blurContainer, cornerRadius: 20)
        self.eventImage.layer.cornerRadius = self.eventImage.frame.size.width / 2
        self.eventImage.clipsToBounds = true
        
    }
    private func RoundFrameOnly(_ aView: UIView!, cornerRadius: CGFloat!) {
        aView.clipsToBounds = true
        aView.layer.cornerRadius = cornerRadius
    }
}
