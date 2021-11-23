//
//  CommentViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/19.
//

import UIKit

class CommentViewController: UIViewController {

    
    //MARK: - Property
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // table view custom
        tableView.rowHeight = Style.commentListHeight
        
        // custom cell
        let commentNibName = UINib(nibName: XibName.commentCustomCell, bundle: nil)
        let replyNibName = UINib(nibName: XibName.replyCustomCell, bundle: nil)
        tableView.register(commentNibName, forCellReuseIdentifier: "commentCell")
        tableView.register(replyNibName, forCellReuseIdentifier: "replyCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
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

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
    
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! ReplyCustomCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCustomCell
        }
        
        cell.selectionStyle = .none

       return cell
    }
    
    
}
