//
//  Category.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/25.
//

import Foundation

struct Categorys: Codable {
    var count: Int
    var categorys: [Category]
}

struct CategoryInfo: Codable {
    var category: Category
    var products: [Product]
}

struct Category: Codable {
    var categoryID: Int
    var categoryName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}
