//
//  ListViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/17.
//

import UIKit
import Alamofire
class ListViewController: HeaderViewController {
    var categories:CategoryInfo?
    var products: [Product]?
    /*검색*/
    @IBOutlet var buttonAttribute: [UIButton]!
    var categoryBtn:Int = 1
    /*검색 - 개별 아울렛*/
    @IBOutlet weak var allsearch: UIButton!
    @IBOutlet weak var foodSearch: UIButton!
    @IBOutlet weak var householdSearch: UIButton!
    @IBOutlet weak var kitchenSearch: UIButton!
    @IBOutlet weak var bathSearch: UIButton!
    @IBOutlet weak var stationarySearch: UIButton!
    @IBOutlet weak var etcSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var stackView: UIStackView!
    let myColor = UIColor(hex: Theme.primary)
    override func viewDidLoad() {
        super.viewDidLoad()

        allsearch.layer.borderColor = myColor?.cgColor
        foodSearch.layer.borderColor = myColor?.cgColor
        householdSearch.layer.borderColor = myColor?.cgColor
        kitchenSearch.layer.borderColor = myColor?.cgColor
        bathSearch.layer.borderColor = myColor?.cgColor
        stationarySearch.layer.borderColor = myColor?.cgColor
        etcSearch.layer.borderColor = myColor?.cgColor

//        stackView.alignment = .firstBaseline
//        stackView.distribution = .equalSpacing
        
        setRadius(radius: 10)
        setBorder(border: 2)
        // Do any additional setup after loading the view.
//        tableView.rowHeight = Style.searchListHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 237
        
        getProductList()
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
    
   
    
    @IBAction func selectedFood(_ sender: UIButton) {
        getCategoryList(id:1)
        
    }
    
    @IBAction func selectedHousehold(_ sender: UIButton) {
        getCategoryList(id:2)
    }
    
    
    @IBAction func selectedKitchen(_ sender: UIButton) {
        getCategoryList(id:3)
    }
    
    @IBAction func selectedBath(_ sender: UIButton) {
        getCategoryList(id:4)
    }
    
    @IBAction func selectedStationery(_ sender: UIButton) {
        getCategoryList(id:5)
    }
    
    @IBAction func selectedEtc(_ sender: UIButton) {
        getCategoryList(id: 6)
    }
    @IBAction func selectedAll(_ sender: UIButton) {
        getProductList()
    }
    @IBAction func selectedButton(_ sender:UIButton){
//        for button in buttons{
//            button.backgroundColor = .clear
//        }
//        categoryBtn = sender.tag
        let selectedColor = UIColor(displayP3Red: 189.0/255.0, green: 172.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        let defaultColor = UIColor(hex: Theme.primary)

        sender.layer.borderColor  = sender.layer.borderColor == selectedColor.cgColor ? defaultColor?.cgColor : selectedColor.cgColor
    }
    
//    func tappedBtn(_ sender:UIButton){
//        switch UIButton.isSelected == true{
//        case allsearch.isSelected: break
//            allsearch.setTitleColor(.white, for: .selected)
//        }
//    }
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
//                    print(json.category.products)
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
    
    func getProductList() {
        let url = "http://20.196.209.221:8000/products"
        let root = AF.request(url, method: .get)
        root.responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(Products.self, from: data)
                    self.products = json.products
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

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
