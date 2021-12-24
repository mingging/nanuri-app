//
//  RegisterViewController.swift
//  nanuri-app
//
//  Created by ShKim on 2021/11/18.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var townTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myColor = UIColor(hex: Theme.primary)
        
        /*
        nickNameTextField.layer.borderColor = myColor?.cgColor
//        townTextField.layer.borderColor = myColor?.cgColor
        
        nickNameTextField.layer.borderWidth = 3.0*/
//        townTextField.layer.borderWidth = 2.0
        
        nickNameTextField.setUnderLine()
        townTextField.text = "서울시 금천구"
       
    }
    
    
    
    @IBAction func actChecked(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    @IBAction func actChecked2(_ sender: UIButton) {
        sender.isSelected.toggle()
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
    func setUnderLine() {
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
