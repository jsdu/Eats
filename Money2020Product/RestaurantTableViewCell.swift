//
//  StoreTableViewCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var promoImage: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var address: UILabel!
    
    @IBOutlet var promoImageWrapper: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var store: Store! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        
        // Set up cell
        promoImage.image = store.image
        name.text = store.name
        address.text = store.address
        backgroundCardView.cardView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
