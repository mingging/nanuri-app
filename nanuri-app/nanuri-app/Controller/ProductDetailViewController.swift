//
//  ProductDetailViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/17.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    
    //MARK: - Property
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var endDayLabel: UILabel!
    
    @IBOutlet weak var totalPeopleLabel: UILabel!
    @IBOutlet weak var currentPeopleLabel: UILabel!

    @IBOutlet weak var dDayLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var dDayView: UIView!
    @IBOutlet weak var deliveryView: UIView!
    
    @IBOutlet weak var nicNameLabel: UILabel!
    
    @IBOutlet weak var processText: UITextView!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var jointPurchaseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // view custom style
        viewCustom()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
    }
    
    //MARK: - Action
    
    @IBAction func linkToProduct(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - View Custom Style
    
    func viewCustom() {
        // dday, delivery view custom
        // radius
        dDayView.layer.cornerRadius = Style.radius
        deliveryView.layer.cornerRadius = Style.radius
        
        // background color
        dDayView.backgroundColor = UIColor(hex: Theme.primary)
        deliveryView.backgroundColor = UIColor(hex: Theme.secondary)
        
        // text color
        categoryLabel.textColor = UIColor(hex: Theme.secondary)
        productNameLabel.textColor = UIColor(hex: Theme.primary)
        dDayLabel.textColor = UIColor(hex: Theme.secondary)
        deliveryLabel.textColor = UIColor(hex: Theme.primary)
        
        // button custom
        jointPurchaseButton.backgroundColor = UIColor(hex: Theme.primary)
        jointPurchaseButton.layer.cornerRadius = 0.0
        

    }

}
