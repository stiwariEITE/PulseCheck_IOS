//
//  Behaviours.swift
//  DropDownMenu
//
//  Created by Venkatesh Aluri on 29/12/17.
//  Copyright © 2017 Venkatesh Aluri. All rights reserved.
//

import Foundation


struct Categories: Decodable{
    let category: String
    let behaviors: [Behaviours]
}

struct Behaviours: Decodable {
    let BehaviorId: Int
    let BehaviorText: String
    let Category: String
}



