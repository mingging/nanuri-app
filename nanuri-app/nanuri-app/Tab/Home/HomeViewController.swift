//
//  HomeViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit


//MARK: - Home

class HomeViewController: HeaderViewController {
    
    let rowHeight:CGFloat = 237

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = rowHeight
        tableView.separatorStyle = .none
        
        // custom cell
        let nibName = UINib(nibName: XibName.productCustomCell, bundle: nil)
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

//MARK: - UITableViewDelegate, DataSource

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
        cell.progress.progressTintColor = UIColor(hex: Theme.secondary)
        
        // view custom
        cell.dDayView.layer.cornerRadius = Style.radius
        cell.dDayLabel.textColor = UIColor(hex: Theme.secondary)
        cell.dDayView.layer.backgroundColor = UIColor(hex: Theme.primary)?.cgColor
        cell.productNameLabel.textColor = UIColor(hex: Theme.primary)
        
        cell.productNameLabel.text = "마이쮸를 좋아한다면?"
        cell.dDayLabel.text = "1"
        
       
        
        return cell
    }
    
    
}

extension HomeViewController {
    
    //MARK: - BarButtonItem Action
    
    // bar buttonitme custom
    
}
