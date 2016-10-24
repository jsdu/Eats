//
//  ItemNutritionFactsCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation

import Foundation
import UIKit
class ItemNutritionFactsCell: UITableViewCell {
    
    @IBOutlet var nutritionTitleLabel: UILabel!
    
    @IBOutlet var nutritionAmountLabel: UILabel!
    
    @IBOutlet var backgroundCardView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCardView.cardView()
    }
}
