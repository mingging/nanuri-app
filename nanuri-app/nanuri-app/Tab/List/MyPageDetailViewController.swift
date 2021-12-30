//
//  MyPageDetailViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/23.
//

import UIKit

//import PhotosUI

class MyPageDetailViewController: UIViewController {
    let containerName = "nanuriImages"
    let connectionString:String = "DefaultEndpointsProtocol=https;AccountName=logvieoblobimgs;AccountKey=LmiLJOBXGakx9UodRVLenmDyg8aoRDWabfKIyO28rTOHMRptZVH2oooHj0TEOGKQwwxDWrmcaa2/N/apD3e2wg==;EndpointSuffix=core.windows.net"
    let myColor = UIColor(hex: Theme.primary)
    
    
    @IBOutlet weak var userInfoDeleteBtn: UIButton!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var bankAccountNum: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var searchTown: UIView!
    
    @IBOutlet weak var profilePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        imageView.layer.borderColor = myColor?.cgColor
        imageView.layer.borderWidth = 1.5
//        imageView.addSubview(imageView)
        submitButton.titleLabel?.adjustsFontSizeToFitWidth = true

        submitButton.titleLabel?.minimumScaleFactor = 10.0
        self.tabBarController?.tabBar.isHidden = true
        
        nickTextField.hideUnderLine()
        bankTextField.hideUnderLine()
        bankAccountNum.hideUnderLine()
        
        userInfoDeleteBtn.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
        /*
        dropDown.show()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            searchTown.UIView = item
            searchTown.UIView = index
            
//            self.dropDown.
             
            self.dropDown.selectRow(at: 6)
//            self.dropDown.clearSelection()
         }
         */
            
        if let data = UserDefaults.standard.data(forKey: "profile_image"){
            profilePhoto.image = UIImage(data: data)
        } else {
            let photo  = UIImage(named:"logo_sample")
            profilePhoto.image = photo
        }
        
        
    }
    
    @IBAction func profilePhotoUpload(_ sender: Any) {
//        picker.sourceType = .photoLibrary
//        present(picker, animated: true)
        
    }
//    @IBAction func showDropDown(_ sender: Any) {
//        DropDown.startListeningToKeyboard()
//        dropDown.dataSource = ["강서구","강남구","강동구","금천구","성동구","마포구"]
//        dropDown.show()
//        
//        dropDown.anchorView = searchTown
//        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
//        dropDown.width = 327
//        // 선택한 값 가져오기
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("선택한 아이템 : \(item)")
//            print("인덱스 : \(index)")
////            self.dropDown.
//             
//            self.dropDown.selectRow(at: 6)
////            self.dropDown.clearSelection()
//            
//        }
//    }
    func userSelectedPhoto(_ image: UIImage){
        // 이미지 피커 didFinish 선택한 이미지를 이미지뷰에 업데이트, 모델 호출, 레이블 적용
        DispatchQueue.main.async {
            // 메인 스레드에서 이미지 업데이트
            self.profilePhoto.image = image
        }
        
    }
    
    
    @IBAction func actSaveUserInfo(_ sender: Any) {
        if let data = profilePhoto.image?.pngData(){
            UserDefaults.standard.set(data, forKey: "profile_image")
        }
            
//        UserDefaults.standard.set("logo2.png", forKey: "profile_image")
//        dismiss(animated: true){
//            self.diaryVC?.reloadData()
//        }
//
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


