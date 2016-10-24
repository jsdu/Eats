//
//  DiscountViewController.swift
//  DigiMart
//
//  Created by JasonDu on 2016-10-20.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import PickerView

class DiscountViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var backgroundCardView: UIView!
    
    @IBOutlet var pickerView: PickerView!
    
    var takenImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = takenImage
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.scrollingStyle = .default
        pickerView.selectionStyle = .defaultIndicator
        pickerView.selectRow(0, animated: false)
        pickerView.defaultSelectionIndicator.tintColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        pickerView.defaultSelectionIndicator.backgroundColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        
        pickerView.cardView()
        
        backgroundCardView.cardView()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitClicked(_ sender: AnyObject) {
        Singleton.sharedInstance.discount = true
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func backClicked(_ sender: AnyObject) {
        Singleton.sharedInstance.discount = false
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension DiscountViewController: PickerViewDataSource {
    
    // MARK: - PickerViewDataSource
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return Singleton.sharedInstance.itemArr.count
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        let item:Item = Singleton.sharedInstance.itemArr[index]
        return item.name
    }
}


extension DiscountViewController: PickerViewDelegate {
    
    // MARK: - PickerViewDelegate
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int, index: Int) {
        
    }
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        
        if (highlighted) {
            label.font = UIFont.systemFont(ofSize: 26.0, weight: UIFontWeightLight);
        } else {
            label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight);
        }
        
        if (highlighted) {
            label.textColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        } else {
            label.textColor = UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 161.0/255.0, alpha: 1.0)
        }
    }
    
    func pickerView(_ pickerView: PickerView, viewForRow row: Int, index: Int, highlighted: Bool, reusingView view: UIView?) -> UIView? {
        
        
        let customView = view
        
        
        return customView
    }
    
}

