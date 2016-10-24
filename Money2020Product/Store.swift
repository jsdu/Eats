//
//  Store.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

struct Store {
    let name: String
    let address: String
    let coord: CLLocationCoordinate2D
    let image: UIImage?
    let tags: [String]
    let items: [Item]
}
