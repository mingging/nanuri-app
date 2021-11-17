//
//  HeaderViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/17.
//

import UIKit

class HeaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation Header Custom
        navigationController?.navigationBar.backgroundColor = UIColor(hex: Theme.primary)
        
        // Right Bar Item
        let searchButton = UIImage(named: ImageName.searchIcon)
        let noticeButton = UIImage(named: ImageName.noticeIcon)
        let search = UIBarButtonItem(image: searchButton, style: .plain, target: self, action: nil)
        let notice = UIBarButtonItem(image: noticeButton, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [notice, search]
        
        // Left Bar Item
        let searchTown = UIBarButtonItem(title: "현재 위치", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = searchTown
        
        // Bar Button Custom
        navigationController?.navigationBar.tintColor = .white
                
        
//        guard let font = UIFont(name: "NanumSquareOTFB", size: 14) else { return }
//        searchTown.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
    }
}
