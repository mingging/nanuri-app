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
        let search = UIBarButtonItem(
            image: UIImage(named: ImageName.searchIcon),
            style: .plain,
            target: self,
            action: #selector(clickToSearch(sender:))
        )
        
        let notice = UIBarButtonItem(
            image: UIImage(named: ImageName.noticeIcon),
            style: .plain,
            target: self,
            action: #selector(clickToNotice(sender:))
        )
        
        self.navigationItem.rightBarButtonItems = [notice, search]
        
        // Left Bar Item
        let searchTown = UIBarButtonItem(title: "현재 위치", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = searchTown
        
        // Bar Button Custom
        navigationController?.navigationBar.tintColor = .white
        
//        guard let font = UIFont(name: "NanumSquareOTFB", size: 14) else { return }
//        searchTown.setTitleTextAttributes([NSFontAttributeName: font], for: .normal)
    }
    
    
    //MARK: - Bar Action
    
    @objc func clickToSearch(sender: UIBarButtonItem) {
        print("search")
        let searchView = UIStoryboard(name:Stoyboard.search.name,bundle: nil)
        guard let searchVC = searchView.instantiateViewController(withIdentifier: Stoyboard.search.id) as? SearchViewController else { return }
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func clickToNotice(sender: UIBarButtonItem) {
        let noticeView = UIStoryboard(name: Stoyboard.notice.name, bundle: nil)
        guard let NoticeVC =
                noticeView.instantiateViewController(withIdentifier: Stoyboard.notice.id)
                as? NoticeViewController
        else { return }
        
        self.navigationController?.pushViewController(NoticeVC, animated: true)
    }

}
