//
//  MyPageProductsListViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/28.
//

import UIKit

class MyPageProductsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Style.productListHeight
        tableView.separatorStyle = .none
        
        // custom cell
        let nibName = UINib(nibName: XibName.mypageCustomCell, bundle:nil)
        tableView.register(nibName, forCellReuseIdentifier: "mypageCell")
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

extension MyPageProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "mypageCell", for: indexPath) as! MyPageCustomCell
        cellStyle(myCell)

        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mypageDetailView = UIStoryboard(name: Stoyboard.mypageDetail.name, bundle: nil)
        guard let mypageDetailVC =
                mypageDetailView.instantiateViewController(withIdentifier: Stoyboard.mypageDetail.id) as? MyPageProductDetailViewController
        else { return }

        navigationController?.pushViewController(mypageDetailVC, animated: true)
    }
    
    
    
    //MARK: - Cell Style
    
    func cellStyle(_ cell: MyPageCustomCell) {
        // progress bar custom
        cell.progress.progressTintColor = UIColor(hex: Theme.secondary)
        
        /*
        // view custom
        cell.dDayView.layer.cornerRadius = Style.radius
        cell.dDayLabel.textColor = UIColor(hex: Theme.secondary)
        cell.dDayView.layer.backgroundColor = UIColor(hex: Theme.primary)?.cgColor
        cell.productNameLabel.textColor = UIColor(hex: Theme.primary)
        cell.selectionStyle = .none
        */
        // cell shadow, radius
        cell.cellView.layer.masksToBounds = false
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = Float(Style.shadowOpacity)
        cell.cellView.layer.shadowRadius = Style.radius
        cell.cellView.layer.cornerRadius = Style.radius
        cell.cellView.layer.shadowOffset = CGSize(width: 3, height: 3)
        /*
        cell.productNameLabel.text = "캐모마일 45티백 박스"
        cell.dDayLabel.text = "1"
         */
    }
}
