//
//  HeaderController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit

class HeaderController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.backgroundColor = UIColor(hex: Theme.primary.rawValue)
        //statusbarView.backgroundColor = UIColor(hex: Theme.primary.rawValue)
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

