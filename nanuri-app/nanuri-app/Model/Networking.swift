//
//  CategorySingleton.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/25.
//

import Foundation

import Alamofire

class Networking: NSObject {
    static var sharedObject = Networking()
    
    func getCategory(categoryID: Int, result: @escaping () -> ()) {
        let url = "http://20.196.209.221:8000/category/\(categoryID)"
        
        print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] \(url) 👉 \(categoryID)")
        getCategoryRequest(url: url, completion: result)
    }
    
    private func getCategoryRequest(url: String, completion: @escaping () -> ()) {
        let request = AF.request(url, method: .get)
        request.responseString { (response) in
            switch response.result {
                case .success(let value):
                    
                    // do something..
                    
                    completion()
                case .failure(let error):
                    // do something ..
                    
                    print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)]")
            }
        }
    }
}

extension Networking {
    
    /// 회원 정보 불러오기
    /// - Parameters:
    ///   - parameter: 파라미터
    ///   - result: 종료 후 호출 할 Closure
   
}

extension Networking {
    
   
}
