//
//  PayViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/24.
//

import UIKit

import Alamofire

class PayViewController: UIViewController {

    
    //MARK: - Outlet
    
    @IBOutlet weak var payToBank: UIButton!
    @IBOutlet weak var payToCard: UIButton!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var deliveryMethodLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var productName: String?
    var productPrice: Int?
    var deliveryMethod: String?
    var productID: Int?
    var categoryID: Int?
    var productUserID: Int?
    var josinPPL: Int?
    
    var creditMethod: String?
    var isSelectCard = false
    var isSelectBank = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        payToCard.layer.borderWidth = 2
        payToCard.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
        payToCard.layer.cornerRadius = 5
        
        payToBank.layer.borderWidth = 2
        payToBank.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
        payToBank.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        dateSetUp()
    }
    
    func dateSetUp() {
        guard let productName = productName,
              let productPrice = productPrice,
              let deliveryMethod = deliveryMethod
        else {
            return
        }

        productNameLabel.text = productName
        productPriceLabel.text = NumberFormatter().priceFormatter(price: productPrice)
        deliveryMethodLabel.text = deliveryMethod
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
    }

    func postOrder() {
       
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
 
    
    //MARK: - Action
    
    @IBAction func clickToBank(_ sender: UIButton) {
        isSelectCard = true
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        payToCard.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
    }
    
    @IBAction func clickToCard(_ sender: UIButton) {
        isSelectBank = true
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        payToBank.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
    }

    @IBAction func payAction(_ sender: UIButton) {
        if isSelectCard || isSelectBank {
            
            if isSelectCard {
                creditMethod = "카드"
            } else {
                creditMethod = "계좌"
            }
            
            guard let method = creditMethod,
                  let productID = productID,
                  let user = UserSingleton.shared.userData,
                  let productName = productName,
                  let productPrice = productPrice,
                  let productUserID = productUserID,
                  let categoryID = categoryID,
                  let joinPPL = josinPPL
            else { return }
           
                    
            let url = "http://20.196.209.221:8000/order/"
            let productUrl = "http://20.196.209.221:8000/products/\(productID)"
            
            let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
            let parameter = [
                "user_id": user.user.userID,
                "product_id": productID,
                "credit_method": method
            ] as [String : Any]
            
            let productParameter = [
                "product_id": productID,
                "join_ppl_cnt": joinPPL,
                "user_id": productUserID,
                "category_id": categoryID
            ]
            
            AF.upload(multipartFormData: { multiFormData in
                for (key, value) in parameter {
                    multiFormData.append(Data("\(value)".utf8), withName: key)
                }
            }, to: url, headers: header).responseDecodable(of: OrderPostResponse.self) { response in
                switch response.result {
                case .success(_):
                    print("결제 성공")
                
                    
                    AF.upload(multipartFormData: { multiFormData in
                        for (key, value) in productParameter {
                            multiFormData.append(Data("\(value)".utf8), withName: key)
                        }
                    }, to: productUrl, method: .put , headers: header).responseDecodable(of: ProductPutResponse.self) { response in
                        switch response.result {
                        case .success(_):
                            let completeView = UIStoryboard(name: "Pay", bundle: nil)
                            let completeVC = completeView.instantiateViewController(withIdentifier: "completeView") as! PayCompleteViewController
                            completeVC.productName = productName
                            completeVC.productPrice = productPrice
                            self.navigationController?.pushViewController(completeVC, animated: true)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            let alert = UIAlertController(title: "나누리", message: "결제 수단을 선택해주세요!", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil )
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
