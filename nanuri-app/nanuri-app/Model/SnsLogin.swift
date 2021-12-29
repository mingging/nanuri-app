//
//  SnsLogin.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/28.
//

import Foundation

struct SocialLogins:Codable{
    
    var data:[SnsId]
  
}

struct SnsId:Codable{
    var id:Int
    var socialId:String
    
    enum CodingKeys:String, CodingKey {
        case id
        case socialId = "social_id"
    }
}
