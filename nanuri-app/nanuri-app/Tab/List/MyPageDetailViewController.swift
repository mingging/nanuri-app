//
//  MyPageDetailViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/23.
//

import UIKit

class MyPageDetailViewController: UIViewController {
    let myColor = UIColor(hex: Theme.primary)
    
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var bankAccountNum: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imageView.layer.borderColor = myColor?.cgColor
        imageView.layer.borderWidth = 1.5
//        imageView.addSubview(imageView)
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        button.titleLabel?.minimumScaleFactor = 10.0
        self.tabBarController?.tabBar.isHidden = true
        
        nickTextField.hideUnderLine()
        bankTextField.hideUnderLine()
        bankAccountNum.hideUnderLine()
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UITextField {
    func hideUnderLine() {
        let border = CALayer()
//        let width = CGFloat(0.5)
        let myColor = UIColor(hex: Theme.primary)
        border.borderColor = myColor?.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width:  self.frame.size.width, height:1)
        
        border.backgroundColor = myColor?.cgColor
        borderStyle = .none
        layer.addSublayer(border)
//        border.borderWidth = width
//        self.layer.addSublayer(border)
//        self.layer.masksToBounds = true
    }
}
