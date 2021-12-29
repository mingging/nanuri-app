//
//  SnsUserInfo.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/29.
//

import Foundation

class SnsUserInfoSingleton{
    static let shared = SnsUserInfoSingleton()
    
    var id: Int?
    var kakaoUserId:String?
    
    private init(){ }
}
