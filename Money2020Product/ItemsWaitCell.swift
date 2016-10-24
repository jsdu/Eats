//
//  ItemsWaitCell.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit
class ItemsWaitCell: UITableViewCell {
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var waitLabel: UILabel!

    @IBOutlet var activityIndicator: NVActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        // Xcode 8 workaround
        if self.frame.size.width == 1000 && self.frame.size.height == 1000 {
            guard let widthConstraint = (self.constraints.filter { return $0.firstAttribute == .width }).first else { return }
            guard let heightConstraint = (self.constraints.filter { return $0.firstAttribute == .height }).first else { return }
            self.frame.size = CGSize(width: widthConstraint.constant, height: heightConstraint.constant)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundCardView.cardView()
        self.layoutIfNeeded()
        self.activityIndicator.startAnimating()
    }
    
    
    
}
