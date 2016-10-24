//
//  StoreTableViewController.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class StoreTableViewController: UITableViewController,ARDataSource,CLLocationManagerDelegate {
    
    var stores = [Store]()
    var filteredStores = [Store]()
    let searchController = UISearchController(searchResultsController: nil)
    var chosenCellIndex: Int?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    var annotations = [ARAnnotation]()
    
    override func viewDidAppear(_ animated: Bool) {
        callServer()
    }
    
    override func viewDidLoad()
    {
        
        
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.stores = [Store(name: "Grimaldi's",
                             address:"9595 S Eastern Ave",
                             coord:CLLocationCoordinate2D(latitude: 36.12135971, longitude: -115.15709673),
                             image:UIImage(named: "spaghetti"),
                             tags:["pizza","olive", "dinner"],
                             items:[Item(name:"Spaghetti & Meatballs",
                                         desc:"Meatballs atop a bed of pasta covered in a rich tomato sauce",
                                         nutrientName:["Calories","Total Fat","Cholesterol","Sodium","Potassium"],
                                         nutrients:["400","16 g", "29 g","1,295 mg","826 mg"],
                                         price:13.75,
                                         userImg:["spaghetti1","spaghetti2","spaghetti3"]),
                                    Item(name:"Cheese Ravioli",
                                         desc:"Cheese Ravioli with Fresh Tomato Sauce",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:13.75,
                                         userImg:["template_pizza","template_pizza","template_pizza"]),
                                    Item(name:"Buffalo Wings",
                                         desc:"Meaty chicken wings, seasoned with our special spices",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:10.00,
                                         userImg:["template_pizza","template_pizza","template_pizza"]),
                                    Item(name:"Meatballs with Marina Sauce",
                                         desc:"Supersize Meatballs in Marinara Sauce",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:7.50,
                                         userImg:["template_pizza","template_pizza","template_pizza"]),
                                    Item(name:"Eggplant Parmesan",
                                         desc:"Tender, breaded eggplant cutlets",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:12.75,
                                         userImg:["template_pizza","template_pizza","template_pizza"]),
                                    Item(name:"Homemade Mozzarella Cakes",
                                         desc:"Mozzarella coated in homemade bread crumbs",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:12.75,
                                         userImg:["template_pizza","template_pizza","template_pizza"])]),
                       Store(name: "Outback Steakhouse",
                             address:"118 E Lake Mead Pkwy",
                             coord:CLLocationCoordinate2D(latitude: 36.14513655, longitude: -115.17808356),
                             image:UIImage(named: "steak"),
                             tags:["pizza","olive", "dinner"],
                             items:[Item(name:"Pizza entree",
                                         desc:"Pizza description la la la",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:25.00,
                                         userImg:["template_pizza","template_pizza","template_pizza"]),
                                    Item(name:"Pizza side dish",
                                         desc:"Pizza description la la la",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:7.00,
                                         userImg:["template_pizza","template_pizza","template_pizza"])]),
                       Store(name: "Yama Sushi",
                             address:"99 Townsend St",
                             coord:CLLocationCoordinate2D(latitude: 36.09655081, longitude: -115.17811192),
                             image:UIImage(named: "sushi"),
                             tags:["pizza","olive", "dinner"],
                             items:[Item(name:"Pizza entree",
                                         desc:"Pizza description la la la",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:25.00,
                                         userImg:["template_pizza","template_pizza","template_pizza"])]),
                       Store(name: "Alexander's Pizza",
                             address:"99 Townsend St",
                             coord:CLLocationCoordinate2D(latitude: 36.10414038, longitude: -115.19413589),
                             image:UIImage(named: "template_pizza"),
                             tags:["pizza","olive", "dinner"],
                             items:[Item(name:"Pizza entree",
                                         desc:"Pizza description la la la",
                                         nutrientName:["Calories","Fat","Glucose"],
                                         nutrients:["50 grams","25 grams", "30 grams"],
                                         price:25.00,
                                         userImg:["template_pizza","template_pizza","template_pizza"])])]
        self.tableView.reloadData()
        self.tableView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        
        for store in stores {
            let newAnnotation = ARAnnotation()
            newAnnotation.title = store.name
            newAnnotation.location = CLLocation(latitude: store.coord.latitude, longitude: store.coord.longitude)
            self.annotations.append(newAnnotation)
        }
        
        // Setup the Search Controller
        //        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Setup the Scope Bar
        tableView.tableHeaderView = searchController.searchBar
        
        // Setup the Searchbar
        UISearchBar.appearance().barTintColor = UIColor.white
        UISearchBar.appearance().tintColor = UIColor(red:0.20, green:0.80, blue:1.00, alpha:1.0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredStores.count
        }
        return stores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Store Cell", for: indexPath) as! StoreTableViewCell
        var store: Store
        if searchController.isActive && searchController.searchBar.text != "" {
            store = filteredStores[indexPath.row]
        } else {
            store = self.stores[indexPath.row]
        }
        cell.store = store
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredStores = stores.filter({( store : Store) -> Bool in
            print ("THE STORE HAS THESE TAGS:\(store.tags.description)")
            print ("The search text is: \(searchText.lowercased())")
            for checkTag in store.tags {
                if (checkTag.lowercased().range(of: searchText.lowercased()) != nil) {
                    return true
                }
            }
            return false
        })
        tableView.reloadData()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = self.tableView.contentOffset.y
        for cell in self.tableView.visibleCells as! [StoreTableViewCell] {
            let x = cell.promoImage.frame.origin.x
            let w = cell.promoImage.bounds.width
            let h = cell.promoImage.bounds.height
            let y = ((offsetY - cell.frame.origin.y) / h) * 15
            cell.promoImage.frame = CGRect(x:x,y:y,width: w,height: h)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCellIndex = indexPath.row
        print("I CHANGED THE CELL INDEX TO: \(chosenCellIndex)")
        self.performSegue(withIdentifier: "toMenu", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let ItemsViewController = segue.destination as! ItemsViewController
        
        // set a variable in the second view controller with the data to pass
        print("Perform SEGUE")
        ItemsViewController.store = stores[chosenCellIndex!]
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        self.currentLocation = CLLocationCoordinate2DMake(location!.coordinate.latitude, location!.coordinate.longitude)
        print("Location found! \(location)")
        self.locationManager.stopUpdatingLocation()
    }
    
    // AR Functionality
    @IBAction func worldButtonTapped(_ sender: AnyObject) {
        showARViewController()
    }
    
    func showARViewController()
    {
        // Check if device has hardware needed for augmented reality
        let result = ARViewController.createCaptureSession()
        if result.error != nil
        {
            let message = result.error?.userInfo["description"] as? String
            let alertView = UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Close")
            alertView.show()
            return
        }
        // Create random annotations around center point    //@TODO
        //FIXME: set your initial position here, this is used to generate random POIs
        
        // Present ARViewController
        let arViewController = ARViewController()
        arViewController.debugEnabled = false
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 100
        arViewController.maxVerticalLevel = 5
        arViewController.headingSmoothingFactor = 0.25
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        arViewController.setAnnotations(self.annotations)
        //arViewController.interfaceOrientationMask = .landscape
        arViewController.onDidFailToFindLocation =
            {
                [weak self, weak arViewController] elapsedSeconds, acquiredLocationBefore in
                
                self?.handleLocationFailure(elapsedSeconds: elapsedSeconds, acquiredLocationBefore: acquiredLocationBefore, arViewController: arViewController)
        }
        self.navigationController?.present(arViewController, animated: true, completion: nil)
    }
    
    /// This method is called by ARViewController, make sure to set dataSource property.
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView
    {
        // Annotation views should be lightweight views, try to avoid xibs and autolayout all together.
        let annotationView = TestAnnotationView()
        annotationView.frame = CGRect(x: 0,y: 0,width: 150,height: 50)
        return annotationView;
    }
    
    fileprivate func getDummyAnnotations(centerLatitude: Double, centerLongitude: Double, delta: Double, count: Int) -> Array<ARAnnotation>
    {
        var annotations: [ARAnnotation] = []
        
        srand48(3)
        for i in stride(from: 0, to: count, by: 1)
        {
            let annotation = ARAnnotation()
            annotation.location = self.getRandomLocation(centerLatitude: centerLatitude, centerLongitude: centerLongitude, delta: delta)
            annotation.title = "POI \(i)"
            annotations.append(annotation)
        }
        return annotations
    }
    
    fileprivate func getRandomLocation(centerLatitude: Double, centerLongitude: Double, delta: Double) -> CLLocation
    {
        var lat = centerLatitude
        var lon = centerLongitude
        
        let latDelta = -(delta / 2) + drand48() * delta
        let lonDelta = -(delta / 2) + drand48() * delta
        lat = lat + latDelta
        lon = lon + lonDelta
        return CLLocation(latitude: lat, longitude: lon)
    }
    
    func handleLocationFailure(elapsedSeconds: TimeInterval, acquiredLocationBefore: Bool, arViewController: ARViewController?)
    {
        guard let arViewController = arViewController else { return }
        
        NSLog("Failed to find location after: \(elapsedSeconds) seconds, acquiredLocationBefore: \(acquiredLocationBefore)")
        
        // Example of handling location failure
        if elapsedSeconds >= 20 && !acquiredLocationBefore
        {
            // Stopped bcs we don't want multiple alerts
            arViewController.trackingManager.stopTracking()
            
            let alert = UIAlertController(title: "Problems", message: "Cannot find location, use Wi-Fi if possible!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Close", style: .cancel)
            {
                (action) in
                
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            
            self.presentedViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        Singleton.sharedInstance.itemArr = []
        Singleton.sharedInstance.itemProgressArr = []
        Singleton.sharedInstance.quantityArr = []
        Singleton.sharedInstance.checkIn = false
        Singleton.sharedInstance.discount = false
    }
    
    func callServer(){
        
        let defaultConfigObject:URLSessionConfiguration  = URLSessionConfiguration.default
        
        let apiSession: URLSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        
        var request = URLRequest(url: URL(string: "http://10.101.0.144:8181/api/v1/locations")!)
        request.httpMethod = "POST"
        
        let requestDictionary:[String: Any] = ["etc_cust_code": "sampleData"]
        do {
            let requestjson = try requestDictionary.jsonEncodedString()
            let requestdata = requestjson.data(using:String.Encoding.utf8)
            apiSession.uploadTask(with: request, from: requestdata,
                                  completionHandler:{
                                    (data, response, error) -> Void in
                                    print("Got response \(response) with error \(error).\n")
                                    guard response != nil else {
                                        print("\(error)")
                                        return
                                    }
                                    var datastring = String(data: data!, encoding: String.Encoding.utf8)
                                    print("DATA(signup response):\n\(datastring!)\nEND DATA\n")
            }).resume()
        } catch {
            print("json encoding failed")
        }
    }
    
}

extension StoreTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
