//
//  SearchViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/01.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    /*검색*/
    @IBOutlet var buttonAttribute: [UIButton]!
    /*검색 - 개별 아울렛*/
    @IBOutlet weak var allsearch: UIButton!
    @IBOutlet weak var foodSearch: UIButton!
    @IBOutlet weak var householdSearch: UIButton!
    @IBOutlet weak var kitchenSearch: UIButton!
    @IBOutlet weak var bathSearch: UIButton!
    @IBOutlet weak var stationarySearch: UIButton!
    @IBOutlet weak var etcSearch: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    let myColor = UIColor(hex: Theme.primary)
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        allsearch.layer.borderColor = myColor?.cgColor
        foodSearch.layer.borderColor = myColor?.cgColor
        householdSearch.layer.borderColor = myColor?.cgColor
        kitchenSearch.layer.borderColor = myColor?.cgColor
        bathSearch.layer.borderColor = myColor?.cgColor
        stationarySearch.layer.borderColor = myColor?.cgColor
        etcSearch.layer.borderColor = myColor?.cgColor

        stackView.alignment = .firstBaseline
        stackView.distribution = .equalSpacing
        
        setRadius(radius: 10)
        setBorder(border: 2)
        // Do any additional setup after loading the view.
//        tableView.rowHeight = Style.searchListHeight
        
//
    }
    
    
    func setRadius(radius:Int){
        let _ : Int = radius
        for button in buttonAttribute {
//            let radius = 10
            button.layer.cornerRadius = CGFloat(radius)
        }
    }
    
    func setBorder(border:Int){
        let border : Int = border
        for button in buttonAttribute{
            button.layer.borderWidth = CGFloat(Int(border))
        }
    }
    
    @IBAction func selectedButton(_ sender:UIButton){
        let selectedColor = UIColor(displayP3Red: 189.0/255.0, green: 172.0/255.0, blue: 103.0/255.0, alpha: 0.8)
        let defaultColor = UIColor(hex: Theme.primary)
        sender.layer.borderColor  = sender.layer.borderColor == selectedColor.cgColor ? defaultColor?.cgColor : selectedColor.cgColor
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

//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchCustomCell
//
//        return cell
//    }
//
//
//}
