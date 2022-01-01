//
//  SearchViewController.swift
//  nanuri-app
//
//  Created by a0000 on 2021/12/01.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    var categories:CategoryInfo?
    var products: [Product]?
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 237
        
    }
    func categoryBtnClicked(_sender:UIButton){
        let category = [1,2,3,4,5,6,7]
        for eachCate in category{
            _sender.viewWithTag(eachCate)
        }
        
//        _sender.viewWithTag(1)
    }
    
    @IBAction func selectedFood(_ sender: UIButton) {
        getCategoryList(id:1)
        
    }
    
    @IBAction func selectedHousehold(_ sender: UIButton) {
        getCategoryList(id:2)
    }
    /* get */
    func getCategoryList(id:Int){
        var categoryId:Int
        let strURL = "http://20.196.209.221:8000/category/\(id)"
        //let strURL = "http://20.196.209.221:8000/category/categoryId"
        let request = AF.request(strURL,method:.get)
        request.responseJSON{ response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(CategoryInfo.self, from: data)
                    self.products = json.category.products
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch (let error) {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let products = products {
            return products.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let products = products else { return UITableViewCell() }
        let product = products[indexPath.row]
        
        let identifier = "\(indexPath.row) \(product.productId)"

        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = ProductCustomCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            cell.setUpView()
            
            cell.productNameLabel.text = product.productName
            cell.priceLabel.text = NumberFormatter().priceFormatter(price: product.productPrice)
            cell.recruitmentLabel.text = "\(product.joinPPLCnt) / \(product.totalPPLCnt)"
            cell.periodLabel.text = "\(DateFormatter().formatter(date: product.startDate)) ~ \(DateFormatter().formatter(date: product.endDate))"
    
            let percentage = Float(product.joinPPLCnt) / Float(product.totalPPLCnt)
            cell.progress.progress = percentage
            cell.processPercentageLabel.text = "\(Int(percentage * 100))%"
    
            cell .dDayLabel.text = "D - \(calculateDay(endDate: product.endDate))"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailView = UIStoryboard(name: Stoyboard.productDetail.name, bundle: nil)
        guard let productDetailVC =
                productDetailView.instantiateViewController(withIdentifier: Stoyboard.productDetail.id)
                as? ProductDetailViewController,
              let products = products
        else { return }

        let product = products[indexPath.row]
        productDetailVC.productID = product.productId
        productDetailVC.product = product
        
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    


}
