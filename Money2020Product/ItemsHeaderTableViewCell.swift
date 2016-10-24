//
//  ItemsHeaderTableViewCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import MapKit
class ItemsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var imageWrapper: UIView!
    
    @IBOutlet var promoImage: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var backgroundCardView: UIView!
    
    var store: Store! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI(){
        promoImage.image = store.image
        name.text = store.name
        backgroundCardView.cardView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func markerTapped(_ sender: AnyObject) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: store.coord, addressDictionary:nil))
        mapItem.name = store.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    
}
