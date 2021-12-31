//
//  Products.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/25.
//

import Foundation

struct Products: Decodable {
    var count: Int
    var products: [Product]
}

struct ProductPutResponse: Decodable {
    var update: String
    var data: Product
}
