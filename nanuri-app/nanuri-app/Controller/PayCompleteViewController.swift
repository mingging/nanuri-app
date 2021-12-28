//
//  PayCompleteViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/24.
//

import UIKit

class PayCompleteViewController: UIViewController {

    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var productName: String?
    var productPrice: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let productName = productName,
              let productPrice = productPrice
        else { return }
        productPriceLabel.text = NumberFormatter().priceFormatter(price: productPrice)
        productNameLabel.text = productName
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goBackHome(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
