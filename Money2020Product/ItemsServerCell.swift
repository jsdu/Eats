//
//  ItemsServerCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit

class ItemsServerCell: UITableViewCell {
    
    @IBOutlet var callButton: FButton!
    
    @IBOutlet var serverLabel: UILabel!
    
    @IBOutlet var serverPicture: UIImageView!
    
    @IBOutlet var backgroundCardView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCardView.cardView()
        layoutIfNeeded()
        serverPicture.image = roundImage(image: serverPicture.image!)
    }
    
    func roundImage(image:UIImage) -> UIImage
    {
        let newImage = image.copy() as! UIImage
        let cornerRadius = image.size.height/2
        UIGraphicsBeginImageContextWithOptions(image.size, false, 1.0)
        let bounds = CGRect(origin: CGPoint(x: 0,y :0) , size: image.size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        newImage.draw(in: bounds)
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }
}
