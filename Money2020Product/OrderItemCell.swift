//
//  OrderItemCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit
class OrderItemCell: UITableViewCell {
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var statusProgressLabel: UILabel!
    @IBOutlet var status: UILabel!
    
    @IBOutlet var quantity: UILabel!
    
    @IBOutlet var cancelButton: FButton!
    
    @IBOutlet var submitButton: FButton!
    
    @IBOutlet var indicator: NVActivityIndicatorView!
    
    var item: Item! {
        didSet {
            self.updateUI()
        }
    }
    
    var itemIndex:Int = 0
    
    func updateUI(){
        itemName.text = item.name
    }
    
    override func layoutSubviews() {
        //        super.layoutSubviews()
        self.layoutIfNeeded()
        if (Singleton.sharedInstance.itemProgressArr[itemIndex] == "Submit") {
            statusProgressLabel.text = "Processing"
            indicator.isHidden = true
            
        } else if (Singleton.sharedInstance.itemProgressArr[itemIndex] == "Prepare") {
            statusProgressLabel.text = "Preparing"
            cancelButton.isHidden = true
            submitButton.isHidden = true
            indicator.startAnimating()
            indicator.isHidden = false
        } else {
            statusProgressLabel.text = "Done"
        }
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        Singleton.sharedInstance.itemProgressArr[itemIndex] = "Prepare"
        layoutSubviews()
    }
    
   
}
