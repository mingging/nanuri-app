//
//  HomeViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit

import Alamofire
//MARK: - Home

class HomeViewController: HeaderViewController {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // table view settings
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Style.productListHeight
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(bannerImage.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(-100)
        }
        
        // custom cell
//        let nibName = UINib(nibName: XibName.productCustomCell, bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: "cell")
        
        // bar item
    
                
        getProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProductList()
    }
    
    func getProductList() {
        let url = "http://20.196.209.221:8000/products/"
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
    
    @IBAction func addProduct(_ sender: Any) {
        let addView = UIStoryboard(name: Stoyboard.addProduct.name, bundle: nil)
        guard let addVC = addView.instantiateViewController(withIdentifier: Stoyboard.addProduct.id) as? AddProductViewController else { return }
        
        navigationController?.pushViewController(addVC, animated: true)
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
