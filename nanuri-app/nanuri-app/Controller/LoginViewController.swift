//
//  LoginViewController.swift
//  nanuri-app
//
//  Created by ShKim on 2021/11/18.
//

import UIKit
import AuthenticationServices
import Alamofire
/*카카오 로그인 관련 라이브러리*/
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class LoginViewController: UIViewController {
    let email = String?.self
        private let signInButton = ASAuthorizationAppleIDButton()
//    @IBOutlet weak var kakaoLogin: UIButton!
//    @IBOutlet weak var appleLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Apple login
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 60, y: 640, width: 294, height: 31)
//        signInButton.center = view.center
        
    }
    //Apple login
    @objc func didTapSignIn(){
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
        /*Apple 이메일 정보값 Test*/
        /*
         let appleIDProvider = ASAuthorizationAppleIDProvider()
         let request = appleIDProvider.createRequest()
         request.requestedScopes = [.email]
         print("email: \(request.requestedScopes = [.email])")
         //        if email == nil{
         //            if let loginVC = UIStoryboard(name:"Login",bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
         //                loginVC.modalPresentationStyle = .fullScreen
         //                self.present(loginVC, animated: true)
         //            }
         //            //self.tabBarController?.selectedIndex = 0
         //        }
         */
    }
    
    
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
                
                if let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "registerStoryboard") as? RegisterViewController {
                    registerVC.modalPresentationStyle = .fullScreen
                    self.present(registerVC,animated: true)
                    
                }
            }
        }
        /*
         if UserDefaults.standard.string(forKey: "nickname") == nil{
             if let loginVC = UIStoryboard(name:"Home",bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
 //                loginVC.modalPresentationStyle = .fullScreen
 //                self.present(loginVC, animated: true)
                 window?.rootViewController = loginVC
             }
 //            self.tabBarController?.selectedIndex = 0
         } else {
              let tabBarVC = UIStoryboard(name:"Main",bundle: nil).instantiateViewController(withIdentifier: "tabBar")
 //                loginVC.modalPresentationStyle = .fullScreen
 //                self.present(loginVC, animated: true)
                 window?.rootViewController = tabBarVC

         }
         */
    }
    func userInfo(){
        //shared 라는 건 singleton 객체라는 것
        UserApi.shared.me { user, error in
            if let error = error { /*error 가 !nil*/
                print(error.localizedDescription)
                return
            } else {
                //내부적으로 쓰는 구분..?
                if let id =  user?.id {
                    //                    self.lblId.text = "\(id)"
                    print("@@@\(id)")
                }
                //                self.lblNick.text = user?.kakaoAccount?.profile?.nickname
                
                
                
            }
        }
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

/* 인증요청 결과에 대한 정보를 제공하기 위한 인터페이스 */
//extension LoginViewController:ASAuthorizationControllerDelegate{
//    /* 비동기로 동작, delegate pattern */
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        switch authorization.credential{
//        case let credential as ASAuthorizationAppleIDCredential:
//            let firstName = credential.fullName
//            let email = credential.email
//            break
//        default:
//            break
//        }
//        //let credential = authorization.credential as? ASAuthorizationAppleIDCredential
////        print(credential?.user)
////        print(credential?.fullName)
////        print(credential?.email)
//    }
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print(error.localizedDescription)
//    }
//}

extension LoginViewController : ASAuthorizationControllerDelegate  {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("👨‍🍳 \(user)")
            if let email = credential.email {
                print("✉️ \(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error \(error)")
    }
    
}

extension LoginViewController:ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
/*
 func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
     switch authorization.credential {
     // Apple ID
     case let appleIDCredential as ASAuthorizationAppleIDCredential:
             
         // 계정 정보 가져오기
         let userIdentifier = appleIDCredential.user
         let fullName = appleIDCredential.fullName
         let email = appleIDCredential.email
             
         print("User ID : \(userIdentifier)")
         print("User Email : \(email ?? "")")
         print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
  
     default:
         break
     }
 }
 */


