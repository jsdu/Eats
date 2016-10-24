//
//  OrderDiscountCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//
import Foundation
import UIKit

class OrderDiscountCell: UITableViewCell {
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var cameraButton: FButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCardView.cardView()
    }
}
