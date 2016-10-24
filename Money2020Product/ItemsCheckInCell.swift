//
//  ItemsCheckInCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit

class ItemsCheckInCell: UITableViewCell {
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var deformationView: UIView!
    
    @IBOutlet var peopleLabel: UILabel!
    
    @IBOutlet var stepper: GMStepper!
    
    @IBOutlet var checkinButton: FButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCardView.cardView()
    }
    
}
