//
//  File3.swift
//  Money2020Product
//
//  Created by JasonDu on 2016-10-22.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import UIKit

struct Item: Equatable {
    let name:String
    let desc:String
    let nutrientName:[String]?
    let nutrients:[String]?
    let price:Float
    let userImg:[String]?
}

func ==(lhs:Item, rhs:Item) -> Bool { // Implement Equatable
    return lhs.name == rhs.name && lhs.desc == rhs.desc
}
