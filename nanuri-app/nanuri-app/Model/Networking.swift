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
    
    func getUserInfo(userID: Int, result: @escaping (_ response: User) -> ()) {
        let url = "http://20.196.209.221:8000/users/\(userID)"
        
        print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] \(url) 👉 \(userID)")
        getUserRequest(url: url, completion: result)
    }
    
    private func getUserRequest(url: String, completion: @escaping (_ response: User) -> ()) {
        let root = AF.request(url, method: .get)
        root.responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(_):
                guard let result = response.value else { return }
                completion(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


extension Networking {
    func getProductInfo(productID: Int, response: @escaping (_ response: Product) -> ()) {
        let url = "http://20.196.209.221:8000/products/\(productID)"
        print("\(#file.split(separator: "/").last!)-\(#function)[\(#line)] \(url) 👉 \(productID)")
        getProductRequest(url: url, completion: response)
    }
    
    func getProductRequest(url: String, completion: @escaping (_ response: Product) -> ()) {
        AF.request(url, method: .get).responseDecodable(of: ProductGetResponse.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                completion(response.products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
