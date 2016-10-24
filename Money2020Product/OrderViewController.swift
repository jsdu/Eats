//
//  OrderViewController.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//
import UIKit
import Fusuma

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FusumaDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    var total: Float = 0
    var discountImage: UIImage?
    var discount: Float = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Orders"
    }
    override func viewWillAppear(_ animated: Bool) {
        total = 0
        for index in stride(from: 0, to: Singleton.sharedInstance.itemArr.count, by: 1){
            print(index)
            let item:Item = Singleton.sharedInstance.itemArr[index]
            total = total + item.price * Float(Singleton.sharedInstance.quantityArr[index])
        }
        if (Singleton.sharedInstance.discount) {
            discount = total * 0.1
            total = total - discount
        }
        tableView.reloadData()
    }
    
    @IBAction func BackPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.sharedInstance.itemArr.count + 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (!Singleton.sharedInstance.discount){
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDiscountCell", for: indexPath) as! OrderDiscountCell
                cell.cameraButton.addTarget(self, action: #selector(camera), for: .touchUpInside)
                return cell
            } else if (indexPath.row == 1) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! SectionCell
                return cell
            } else if (indexPath.row != Singleton.sharedInstance.itemArr.count + 2){
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
                cell.item = Singleton.sharedInstance.itemArr[indexPath.row-2]
                cell.itemIndex = indexPath.row-2
                cell.quantity.text = String(Singleton.sharedInstance.quantityArr[indexPath.row-2])
                cell.cancelButton.tag = indexPath.row
                cell.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
                let formatPrice = String(format: "%.2f", cell.item.price * Float(Singleton.sharedInstance.quantityArr[indexPath.row-2]))
                cell.itemPrice.text = "$\(formatPrice)"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
                let formatPrice = String(format: "%.2f", total)
                cell.orderTotal.text = "$\(formatPrice)"
                return cell
            }
        } else {
            
            if (indexPath.row == 0) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! SectionCell
                return cell
            } else if (indexPath.row < Singleton.sharedInstance.itemArr.count + 1) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
                cell.item = Singleton.sharedInstance.itemArr[indexPath.row-1]
                cell.itemIndex = indexPath.row-1
                cell.quantity.text = String(Singleton.sharedInstance.quantityArr[indexPath.row-1])
                cell.cancelButton.tag = indexPath.row
                cell.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
                let formatPrice = String(format: "%.2f", cell.item.price * Float(Singleton.sharedInstance.quantityArr[indexPath.row-1]))
                cell.itemPrice.text = "$\(formatPrice)"
                return cell
            } else if (indexPath.row < Singleton.sharedInstance.itemArr.count + 2) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDiscountTotalCell", for: indexPath) as! OrderDiscountTotalCell
                let formatPrice = String(format: "%.2f", discount)
                cell.discount.text = "-$\(formatPrice)"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTotalCell", for: indexPath) as! OrderTotalCell
                let formatPrice = String(format: "%.2f", total)
                cell.orderTotal.text = "$\(formatPrice)"
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (!Singleton.sharedInstance.discount){
            if (indexPath.row == 0){
                return 95
            } else if (indexPath.row == 1){
                return 20
            } else if (indexPath.row < Singleton.sharedInstance.itemArr.count + 2){
                return 100
            } else {
                return 40
            }
        } else {
            if (indexPath.row == 0){
                return 20
            } else if (indexPath.row < Singleton.sharedInstance.itemArr.count + 1){
                return 100
            } else {
                return 40
            }
        }
    }
    
    
    func camera(sender: UIButton){
        let fusuma = FusumaViewController()
        fusumaTintColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        fusuma.delegate = self
        fusuma.hasVideo = false // If you want to let the users allow to use video.
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func cancel(sender: UIButton){
        tableView.beginUpdates()
        total = 0
        Singleton.sharedInstance.itemArr.remove(at: sender.tag-2)
        Singleton.sharedInstance.itemProgressArr.remove(at: sender.tag - 2)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        tableView.deleteRows(at: [indexPath], with: .left)
        viewWillAppear(true)
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    public func fusumaImageSelected(_ image: UIImage) {
        
        print("Image selected")
    }
    
    // Return the image but called after is dismissed.
    public func fusumaDismissedWithImage(_ image: UIImage) {
        
        print("Called just after FusumaViewController is dismissed.")
        discountImage = image
        self.performSegue(withIdentifier: "toDiscount", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        if (segue.identifier == "toDiscount"){
            let ItemViewController = segue.destination as! DiscountViewController
            
            // set a variable in the second view controller with the data to pass
            if (discountImage != nil){
                ItemViewController.takenImage = discountImage
            }
        }
    }
    
    public func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print ("Video Completed")
    }
    
    // When camera roll is not authorized, this method is called.
    public func fusumaCameraRollUnauthorized() {
        
        print("Camera roll unauthorized")
    }
}
