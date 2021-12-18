//
//  MyPageDetailViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/23.
//

import UIKit
import DropDown

class MyPageDetailViewController: UIViewController {
    let myColor = UIColor(hex: Theme.primary)
    let dropDown = DropDown()
    
    @IBOutlet weak var userInfoDeleteBtn: UIButton!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var bankAccountNum: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var searchTown: UIView!
    
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
            
        
        
        
    }
    
    @IBAction func showDropDown(_ sender: Any) {
        DropDown.startListeningToKeyboard()
        dropDown.dataSource = ["강서구","강남구","강동구","금천구","성동구","마포구"]
        dropDown.show()
        
        dropDown.anchorView = searchTown
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.width = 327
        // 선택한 값 가져오기
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
//            self.dropDown.
             
            self.dropDown.selectRow(at: 6)
//            self.dropDown.clearSelection()
            
        }
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
