//
//  ItemTableViewCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet var slideShow: ImageSlideshow!
    
    @IBOutlet var backgroundCardView: UIView!
    
    var item: Item! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        // Build Image Source Arr
        var imageSourceArr:[ImageSource] = []
        for image in self.item.userImg! {
            imageSourceArr.append(ImageSource(image: UIImage(named: image)!))
        }
        slideShow.setImageInputs(imageSourceArr)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundCardView.cardView()
        slideShow.backgroundColor = UIColor.white
        slideShow.slideshowInterval = 3.0
        slideShow.pageControlPosition = PageControlPosition.custom(padding: 22.0)
        slideShow.pageControl.currentPageIndicatorTintColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        slideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
