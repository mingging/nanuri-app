//
//  SnsLogin.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/28.
//

import Foundation

struct SocialLogins: Decodable {
    var count: Int
    var data: [SnsId]
  
}

struct SnsId: Decodable {
    var id: Int
    var socialId: String
    
    enum CodingKeys:String, CodingKey {
        case id
        case socialId = "social_id"
    }
}


struct SNSPostResponse: Decodable {
    var create: String
    var data: SnsId
}
