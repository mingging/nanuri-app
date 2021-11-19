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
        
        nickNameTextField.layer.borderColor = myColor?.cgColor
        townTextField.layer.borderColor = myColor?.cgColor

        nickNameTextField.layer.borderWidth = 1.0
        townTextField.layer.borderWidth = 1.0
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
