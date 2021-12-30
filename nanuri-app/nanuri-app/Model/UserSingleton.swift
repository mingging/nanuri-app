//
//  UserSingleton.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/24.
//

import Foundation

class UserSingleton {
    static let shared = UserSingleton()
    
    var userData: UserData?
    var orderProductData: [Product]?
    
    private init() {}

}
