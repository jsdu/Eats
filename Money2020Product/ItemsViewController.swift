//
//  ItemsViewController.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var store:Store?
    var isCheckIn = false
    var isWait = false
    var isReady = false
    var isServer = false
    @IBOutlet var viewOrderButton: UIButton!
    
    @IBOutlet var tableView: UITableView!
    var chosenCellIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isCheckIn = true
        self.title = store?.name
        
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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(store!.items.count)
        return store!.items.count + 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Header Cell", for: indexPath) as! ItemsHeaderTableViewCell
            cell.store = store
            return cell
        } else if (indexPath.row == 1){
            if (isCheckIn){
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInCell", for: indexPath) as! ItemsCheckInCell
                cell.checkinButton.addTarget(self, action: #selector(checkIn), for: .touchUpInside)
                return cell
            } else if (isWait) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WaitCell", for: indexPath) as! ItemsWaitCell
                wait()
                return cell
            } else if (isReady){
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReadyCell", for: indexPath) as! ItemsReadyCell
                cell.readyButton.addTarget(self, action: #selector(ready), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ServerCell", for: indexPath) as! ItemsServerCell
                //                cell.readyButton.addTarget(self, action: #selector(ready), for: .touchUpInside)
                return cell
            }

        } else if (indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath) as! SectionCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Item Cell", for: indexPath) as! ItemsTableViewCell
            cell.item = store!.items[indexPath.row-3]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 215
        } else if (indexPath.row == 1){
            return 105
        } else if (indexPath.row == 2){
            return 20
        } else {
            return 60
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.tableView.cellForRow(at: IndexPath(row: 0,section: 0)) != nil){
            let offsetY = self.tableView.contentOffset.y
            let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ItemsHeaderTableViewCell
            let x = cell.promoImage.frame.origin.x
            let w = cell.promoImage.bounds.width
            let h = cell.promoImage.bounds.height
            let y = ((offsetY - cell.frame.origin.y) / h) * 15
            cell.promoImage.frame = CGRect(x:x,y:y,width: w,height: h)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if (indexPath.row >= 3){
            chosenCellIndex = indexPath.row
            self.performSegue(withIdentifier: "toItem", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        if (segue.identifier == "toItem"){
            let ItemViewController = segue.destination as! ItemViewController
            
            // set a variable in the second view controller with the data to pass
            print("Perform SEGUE: \(chosenCellIndex)")
            ItemViewController.item = store?.items[chosenCellIndex!-3]
        }
        
        
    }
    
    func checkIn(sender: UIButton){
        isCheckIn = false
        isWait = true
        self.tableView.reloadData()
    }
    
    func wait() {
        delay(4.0){
            self.isWait = false
            self.isReady = true
            self.tableView.reloadData()
            Singleton.sharedInstance.checkIn = true
        }
    }
    
    func ready(sender: UIButton){
        isReady = false
        isServer = true
        self.tableView.reloadData()
    }
    

    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
}
