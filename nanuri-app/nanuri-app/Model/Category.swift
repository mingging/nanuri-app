//
//  Category.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/25.
//

import Foundation

struct Categorys: Decodable {
    var count: Int
    var categorys: [Category]
}

struct CategoryInfo: Decodable {
    var category: Category
    
}

struct Category: Codable {

    var categoryID: Int
    var categoryName: String
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case products
    }
}

class CategorySingleton {
    static let shared = CategorySingleton()
    
    func categoryToID(category: String) -> Int {
        switch category {
        case "음식":
            return 1
        case "생활용품":
            return 2
        case "주방":
            return 3
        case "욕실":
            return 4
        case "문구":
            return 5
        case "기타":
            return 6
        default:
            return 7
        }
    }
}
