//
//  User.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/24.
//

import Foundation

struct User: Codable {
    var user: UserData
    var products: [Product]
}

struct UserInfo: Codable {
    var user: [UserData]
    var products: [Product]
}

struct UserData: Codable {
    var userID: Int
    var userArea: String
    var userNick: String
    var score: Int
    var userBank: String?
    var bankNum: Int?
    var userNumber: Int?
    var createdAt: String?
    var updateAt: String?
    var socialID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userArea = "user_area"
        case userNick = "user_nick"
        case score = "score"
        case userBank = "user_bank"
        case bankNum = "banknum"
        case userNumber = "user_number"
        case createdAt = "created_at"
        case updateAt = "update_at"
        case socialID = "social_id"
    }
}

struct Product: Codable {
    var productId: Int
    var productName: String
    var link: String
    var productImage: String
    var productPrice: Int
    var totalPPLCnt: Int
    var joinPPLCnt: Int
    var startDate: String
    var endDate: String
    var deliveryMethod: String
    var detailContent: String
    var createAt: String
    var updateAt: String
    var userID: Int
    var categoryID: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case productName = "product_name"
        case link = "link"
        case productImage = "product_image"
        case productPrice = "product_price"
        case totalPPLCnt = "total_ppl_cnt"
        case joinPPLCnt = "join_ppl_cnt"
        case startDate = "start_date"
        case endDate = "end_date"
        case deliveryMethod = "delivery_method"
        case detailContent = "detail_content"
        case createAt = "create_at"
        case updateAt = "update_at"
        case userID = "user_id"
        case categoryID = "category_id"
    }
}

struct UserPostResponse: Decodable {
    var create: String
    var data: UserData
}
