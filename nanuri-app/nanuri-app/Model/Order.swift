//
//  Order.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/30.
//

import Foundation

struct OrderPostResponse: Decodable {
    var success: String
    var comments: Order
}

struct Order: Decodable {
    var userID: Int
    var productID: Int
    var creditMethod: String
    var updateAt: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case productID = "product_id"
        case creditMethod = "credit_method"
        case updateAt = "created_at"
    }
}
