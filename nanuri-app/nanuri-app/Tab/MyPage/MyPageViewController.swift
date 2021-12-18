//
//  MyPageViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/19.
//

import UIKit


class MyPageViewController: HeaderViewController {
    
//    let items = ["내가 구매한 상품", "내가 등록한 상품"]
    @IBOutlet weak var firstView:UIView!
    @IBOutlet weak var secondView:UIView!
    
 
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func switchView(_ sender: UISegmentedControl) {
        //let initView = selectedSegmentIndex
        
        if sender.selectedSegmentIndex == 1 {
            firstView.alpha = 1
            secondView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
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
