//
//  LoginViewController.swift
//  nanuri-app
//
//  Created by ShKim on 2021/11/18.
//

import UIKit

import Alamofire
/*카카오 로그인 관련 라이브러리*/
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

import Alamofire
import SnapKit

class LoginViewController: UIViewController {
//    var socialId:[SocialLogins.SnsId]?
    var socialId:SnsId?
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
   /*민경님-userInfo Test*/
    
    @objc func selectLoginButton() {
//        let params: Parameters = ["user_id":1]
        Networking.sharedObject.getUserInfo(userID: 2) { result in
            UserSingleton.shared.userData = result
            let addView = UIStoryboard(name: "Main" , bundle: nil)
            guard let addVC = addView.instantiateViewController(withIdentifier: "tabBarView") as? TabBarController else { return }
            addVC.modalPresentationStyle = .fullScreen
            
            self.present(addVC, animated: true, completion: nil)
        }
    }
    
    /*Apple Login*/
   /*
    func login(){
        //Apple login
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 60, y: 640, width: 294, height: 31)
    //        signInButton.center = view.center
        
    }
    */
    
    @IBAction func kakaoLoginWithAccount(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                self.userInfo()
                
              
            }
        }

    }
    func userInfo(){
        let strURL = "http://20.196.209.221:8000/logins/"
        //shared 라는 건 singleton 객체라는 것
        UserApi.shared.me { user, error in
            if let error = error { /*error 가 !nil*/
                print(error.localizedDescription)
                return
            } else {
                //내부적으로 쓰는 구분..?
                if let kId =  user?.id {
                    
                    SnsUserInfoSingleton.shared.kakaoUserId = "\(kId)"
                    
                    // test
                    let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
                    let parameters = ["social_id":"\(SnsUserInfoSingleton.shared.kakaoUserId!)"]
                    
                    AF.upload(multipartFormData: { multiFormData in
                        for (key, value) in parameters {
                            multiFormData.append(Data("\(value)".utf8), withName: key)
                        }
                    }, to: strURL, headers: header).responseDecodable(of: SNSPostResponse.self) { response in
                        switch response.result {
                        case .success(_):
                            print("sucess reponse is :\(response)")
                            guard let value = response.value else { return }
                            SnsUserInfoSingleton.shared.id = value.data.id
                            print(SnsUserInfoSingleton.shared.id)
//                            SnsUserInfo.shared.id =
                            if let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "registerStoryboard") as? RegisterViewController {
                                registerVC.modalPresentationStyle = .fullScreen
                                self.present(registerVC,animated: true)
                                
                            }
                        case .failure(let error):
                            
                            print(error.localizedDescription)
                        }
                    }
                    
                    
                    
//                    let params:Parameters = ["social_id":"\(SnsUserInfo.shared.kakaoUserId!)"]
//                    
//                    let request = AF.request(strURL, method: .post, parameters: params)
//
//                    request.responseDecodable(of: SocialLogins.self) { response in
//                        switch response.result{
//                        case .success(let value):
//                            print(value)
//                            print("sucess")
//                        case .failure(let error):
//                            print(error.localizedDescription)
////                            if res.socialId == 1 {
////                                let successAlert = UIAlertController(title:"가입완료",message: "회원가입이 완료되었습니다.", preferredStyle: .alert)
////                                let action = UIAlertAction(title: "확인", style: .default) { action in
////                                    print("가입 성공!🙆‍♀️")
////                                }
////                            }
//                        }
//                    }
                }
                //                self.lblNick.text = user?.kakaoAccount?.profile?.nickname
                
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




