//
//  MyPageDetailViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/23.
//

import UIKit

//import PhotosUI

class MyPageDetailViewController: UIViewController,UITextFieldDelegate {
    
    let myColor = UIColor(hex: Theme.primary)
    let pickerView = UIPickerView()
    let townName = ["서울시 강서구","서울시 강남구","서울시 마포구", "서울시 중구", "서울시 강동구", "서울시 성동구"]
    
    @IBOutlet weak var userInfoDeleteBtn: UIButton!
    
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var bankAccountNum: UITextField!
    
//    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var selectedTown: UITextField!
    
    
    @IBOutlet weak var profilePhoto: UIImageView!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imageView.layer.borderColor = myColor?.cgColor
        imageView.layer.borderWidth = 1.5
//        imageView.addSubview(imageView)
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true

        submitButton.titleLabel?.minimumScaleFactor = 10.0
        //self.tabBarController?.tabBar.isHidden = true
        
        nickTextField.hideUnderLine()
        bankTextField.hideUnderLine()
        bankAccountNum.hideUnderLine()
        
        userInfoDeleteBtn.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
        
        if let data = UserDefaults.standard.data(forKey: "profile_image"){
            profilePhoto.image = UIImage(data: data)
        } else {
            let photo  = UIImage(named:"logo_sample")
            profilePhoto.image = photo
        }
        
        pickerView.dataSource = self
        pickerView.delegate = self
        selectedTown.tintColor = .clear
        createPickerView()
        dismissPickerView()
//        selectedTown.inputView = picker
    }
    /*프로필 업로드 버튼*/
    @IBAction func profilePhotoUpload(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }

    func userSelectedPhoto(_ image: UIImage){
        // 이미지 피커 didFinish 선택한 이미지를 이미지뷰에 업데이트, 모델 호출, 레이블 적용
        DispatchQueue.main.async {
            // 메인 스레드에서 이미지 업데이트
            self.profilePhoto.image = image
        }
        
    }
    
    /*픽커뷰 - 아래서 올라오게*/
    func createPickerView() {
        
        pickerView.delegate = self
        selectedTown.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.donePicker))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        selectedTown.inputAccessoryView = toolBar
    }
    
//    @objc func action() {
//
//       }
    
    @objc func donePicker() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.selectedTown.text = self.townName[row]
        self.selectedTown.resignFirstResponder()
    }
    
    @IBAction func actSaveUserInfo(_ sender: Any) {
        if let data = profilePhoto.image?.pngData(){
            UserDefaults.standard.set(data, forKey: "profile_image")
        }
            
        UserDefaults.standard.set("logo_sample.png", forKey: "profile_image")
        dismiss(animated: true){
//            self.diaryVC?.reloadData()
        }
        let myPageView = UIStoryboard(name: "MyPage", bundle: nil)
        guard let mypageVC =
                myPageView.instantiateViewController(withIdentifier:"myPageView")
                as? MyPageViewController
        else { return }
        
        self.navigationController?.pushViewController(mypageVC, animated: true)
    }
    /*put - alamo*/
    /*
     @IBAction func actPut(_ sender: Any) {
         let strUrl = "http://localhost:8000/users/1"
         let params = ["user_id":"aaa","name":"홍길동","password":"1234","address":"대한민국 서울시"]
         let alamo = AF.request(strUrl,method: .put,parameters: params)
         
         alamo.responseJSON { reponse in
             switch reponse.result{
             case .success(let value):
                 let json = JSON(value)
                 let result = json["success"].boolValue
                 if result {
                     self.showResult(title: "사용자수정", message: "수정성공")
                 } else {
                     self.showResult(title: "사용자수정", message: "수정실패")
                 }
             case .failure(let error):
                 print(error.errorDescription)
             }
         }
         
     }
     */
    func saveUserInfo(){
        let strURL = "http://20.196.209.221:8000/users/"
        guard let userNick = nickTextField.text,
//              let townName = changeTownName,
              let socialIdx = SnsUserInfoSingleton.shared.id
        else { return }
        /*
         let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
         let params:Parameters = ["social_id":socialIdx,"user_nick":userNick,"user_area":townName]
         
         AF.upload(multipartFormData: { multiFormData in
         for (key, value) in params {
         multiFormData.append(Data("\(value)".utf8), withName: key)
         }
         }, to: strURL, headers: header).responseDecodable(of: UserPostResponse.self) { response in
         switch response.result {
         case .success(_):
         
         print("sucess reponse is :\(response)")
         guard let value = response.value else { return }
         print(value)
         Networking.sharedObject.getUserInfo(userID: value.data.userID) { result in
         UserSingleton.shared.userData = result
         
         UserDefaults.standard.set(result.user.userID, forKey: "userID")
         
         let addView = UIStoryboard(name: "Main" , bundle: nil)
         guard let addVC = addView.instantiateViewController(withIdentifier: "tabBarView") as? TabBarController else { return }
         addVC.modalPresentationStyle = .fullScreen
         self.present(addVC, animated: true, completion: nil)
         }
         case .failure(let error):
         print(error.localizedDescription)
         }
         }
         */
      
    }
    /*프로필 사진 업로드 관련 메소드*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage{
            profilePhoto.image = image
        let rotatedImage = rotateImage(image: image)
        let data = rotatedImage?.pngData()
        //runtime 때 경로를 가지고 오는 걸 해야함.
        try? data?.write(to: getFileName()) }//try? : 에러가 나면 nil 을 반환
    }
    
    //파일 저장 시 이름 중복되지 않게 설정해주는 것
    func getFileName()->URL{
        let uniqueName = ProcessInfo.processInfo.globallyUniqueString
        let filename = getDocuments().appendingPathComponent("img_\(uniqueName).png")
        print(filename)
        return filename
    }
    
    func getDocuments()->URL{
        //singleton 객체, sandbox 랑 연관이 있음
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    
    func rotateImage(image:UIImage)->UIImage?{
        if(image.imageOrientation == UIImage.Orientation.up){
            return image
        }
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    
    
    @IBAction func userInfoDelete(_ sender: Any) {
        let alert = UIAlertController(title: "회원탙퇴", message: "정말로 회원탈퇴를 하시겠습니까?", preferredStyle: .alert)
        
//            alert.addAction(action1)
//            alert.addAction(action2)
            
//            self.present(alert, animated: true)
        let action = UIAlertAction(title: "확인", style: .default) { _ in
            print("확인이 눌러졌습니다.")
        }
        
        let action2 = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("cancel")
        }
        
        let action3 = UIAlertAction(title: "삭제", style: .destructive) { _ in
            print("삭제")
        }
        
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        
        present(alert, animated: true) {
            print("Present AlertController")
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
extension MyPageDetailViewController:UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return townName.count
    }
    
}

extension MyPageDetailViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTown.text = self.townName[row]
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return townName[row]
       
    }
}

