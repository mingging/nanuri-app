//
//  RegisterViewController.swift
//  nanuri-app
//
//  Created by ShKim on 2021/11/18.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    var socialId:SnsId?
    var user:UserData?
    
    
    
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
//        townTextField.text = "서울시 금천구"
        
        
    }
    
    
    
    @IBAction func actChecked(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    @IBAction func actChecked2(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    
    @IBAction func ActUserRegistered(_ sender: Any) {
//        let homeView = UIStoryboard(name: Stoyboard.homeView.name, bundle: nil)
//        guard let homeVC = homeView.instantiateViewController(withIdentifier: Stoyboard.homeView.id) as? HomeViewController else { return }
//
//        homeVC.modalPresentationStyle = .fullScreen
//        self.present(homeVC, animated: true, completion: nil)
        
        saveUserInfo()
    }
    
    func saveUserInfo(){
        let strURL = "http://20.196.209.221:8000/users/"
        guard let userNick = nickNameTextField.text,
              let socialIdx = SnsUserInfoSingleton.shared.id
        else { return }
        var townName = townTextField.text
        townName = "서울시 금천구"
        

        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let params:Parameters = ["social_id":socialIdx,"user_nick":userNick,"user_area":townName]
        
        AF.upload(multipartFormData: { multiFormData in
            for (key, value) in params {
                multiFormData.append(Data("\(value)".utf8), withName: key)
            }
        }, to: strURL, headers: header).responseDecodable(of: UserPostResponse.self) { response in
            switch response.result {
            case .success(let value):
               
                print("sucess reponse is :\(response)")
                guard let value = response.value else { return }
               
            
                    let addView = UIStoryboard(name: "Main" , bundle: nil)
                    guard let addVC = addView.instantiateViewController(withIdentifier: "tabBarView") as? TabBarController else { return }
                addVC.modalPresentationStyle = .fullScreen
                    self.present(addVC, animated: true, completion: nil)
                
                
                
                 
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
      
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
