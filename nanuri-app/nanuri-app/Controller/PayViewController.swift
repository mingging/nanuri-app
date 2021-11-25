//
//  PayViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/24.
//

import UIKit

class PayViewController: UIViewController {

    
    //MARK: - Outlet
    
    @IBOutlet weak var payToBank: UIButton!
    @IBOutlet weak var payToCard: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        payToCard.layer.borderWidth = 2
        payToCard.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
        payToCard.layer.cornerRadius = 5
        
        payToBank.layer.borderWidth = 2
        payToBank.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
        payToBank.layer.cornerRadius = 5
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
 
    
    //MARK: - Action
    
    @IBAction func clickToBank(_ sender: UIButton) {
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        payToCard.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
    }
    
    @IBAction func clickToCard(_ sender: UIButton) {
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        payToBank.layer.borderColor = UIColor(hex: Theme.lightGray)?.cgColor
    }
}
