//
//  ItemsTableViewCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var price: UILabel!
    
    @IBOutlet var backgroundCardView: UIView!
    
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
        
        backgroundCardView.cellView()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
