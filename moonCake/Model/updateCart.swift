//
//  updateCart.swift
//  moonCake
//
//  Created by TANG,QI-RONG on 2020/9/14.
//  Copyright © 2020 Steven. All rights reserved.
//

import Foundation

struct cartData: Codable {
    var data: [updateCart]
}


struct updateCart: Codable {
    let cartItemName: String
    let cartCount: String
    let cartTotalPrice: String
    let cartDate: String
    
}
