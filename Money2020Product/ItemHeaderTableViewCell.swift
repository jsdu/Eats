//
//  ItemHeaderTableViewCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ItemHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var imageWrapper: UIView!
    
    @IBOutlet var promoImage: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var price: UILabel!
    
    @IBOutlet var order: UIButton!
    
    @IBOutlet var stepper: GMStepper!
    
    var item: Item! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        // Set up cell
        name.text = item.name
        desc.text = item.desc
        
        let formatPrice = String(format: "%.2f", item.price)
        price.text = "$\(formatPrice)"
        
        promoImage.image = UIImage(named: item.userImg![0])
        backgroundCardView.cardView()
        
        if (!Singleton.sharedInstance.checkIn){
            order.backgroundColor = UIColor.lightGray
            order.isUserInteractionEnabled = false
            stepper.leftButton.backgroundColor = UIColor.lightGray
            stepper.rightButton.backgroundColor = UIColor.lightGray
            stepper.label.backgroundColor = UIColor.darkGray
            stepper.isUserInteractionEnabled = false
        } else {
            order.backgroundColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
            order.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func addOrder(_ sender: AnyObject) {
        Singleton.sharedInstance.itemArr.append(item)
        Singleton.sharedInstance.itemProgressArr.append("Submit")
        Singleton.sharedInstance.quantityArr.append(Int(stepper.value))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
