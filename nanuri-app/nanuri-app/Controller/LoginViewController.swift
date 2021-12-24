//
//  LoginViewController.swift
//  nanuri-app
//
//  Created by ShKim on 2021/11/18.
//

import UIKit

import Alamofire
import SnapKit

class LoginViewController: UIViewController {

    
//    @IBOutlet weak var kakaoLogin: UIButton!
//    @IBOutlet weak var appleLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Login
        let loginButton = UIButton()
        self.view.addSubview(loginButton)
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        loginButton.addTarget(self, action: #selector(selectLoginButton), for: .touchUpInside)
            
    }
    
    @objc func selectLoginButton() {
        let url = "http://20.196.209.221:8000/users/1"
//        let params: Parameters = ["user_id":1]
        let root = AF.request(url, method: .get)
        root.responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(User.self, from: data)
        
                    UserSingleton.shared.userData = json.user
                
                    let addView = UIStoryboard(name: Stoyboard.homeView.name, bundle: nil)
                    guard let addVC = addView.instantiateViewController(withIdentifier: Stoyboard.homeView.id) as? HomeViewController else { return }
                
                    self.present(addVC, animated: true, completion: nil)
                } catch(let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func login(){
        
    }
    
    @IBAction func actLogin(_ sender: Any) {
        /*
        //login()
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "registerStoryboard") else {
               return
           }
           
           //화면 전환 애니메이션을 설정합니다. coverVertical 외에도 다양한 옵션이 있습니다.
           rvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
           
           //인자값으로 다음 뷰 컨트롤러를 넣고 present 메소드를 호출합니다.
           self.present(rvc, animated: true)
        */
        
    }
    
    
    @IBAction func appleLogin(_ sender: Any) {
        
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

/**/
