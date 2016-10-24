//
//  ItemViewController.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var viewOrderButton: UIButton!
    
    var item:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        if (Singleton.sharedInstance.itemArr.count == 0) {
            viewOrderButton.isHidden = true
        } else {
            viewOrderButton.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + (item?.nutrients!.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemHeaderCell", for: indexPath) as! ItemHeaderTableViewCell
            cell.item = self.item
            cell.order.addTarget(self, action: #selector(order), for: .touchUpInside)
            return cell
        } else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! SectionCell
            return cell
        } else if (indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableCell", for: indexPath) as! ItemTableViewCell
            cell.item = self.item
            return cell
        } else if (indexPath.row == 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionCell", for: indexPath) as! SectionCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionFactsCell", for: indexPath) as! ItemNutritionFactsCell
            cell.nutritionTitleLabel.text = item?.nutrientName![indexPath.row-4]
            cell.nutritionAmountLabel.text = item?.nutrients![indexPath.row-4]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 270
        } else if (indexPath.row == 1){
            return 20
        } else if (indexPath.row == 2){
            return 220
        } else if (indexPath.row == 3){
            return 20
        } else {
            return 40
        }
    }
    
    func order(){
        _ = navigationController?.popViewController(animated: true)
    }
    
}
