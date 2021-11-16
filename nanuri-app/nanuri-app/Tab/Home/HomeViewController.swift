//
//  HomeViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit

class HomeViewController: UIViewController{
    
    let ROW_HEIGHT:CGFloat = 237

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = ROW_HEIGHT
        tableView.separatorStyle = .none
        
        // custom cell
        let nibName = UINib(nibName: XibName.ProductCustomCell.name, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "cell")
                
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductCustomCell
        
        // progress bar custom
        cell.progress.progressTintColor = UIColor(hex: Theme.secondary.color)
        
        // view custom
        cell.dDayView.layer.cornerRadius = 5
        cell.dDayView.layer.backgroundColor = UIColor(hex: Theme.primary.color)?.cgColor
        
        cell.productName.text = "마이쮸를 좋아한다면?"
        cell.dDay.text = "1"
        
       
        
        return cell
    }
    
    
}
