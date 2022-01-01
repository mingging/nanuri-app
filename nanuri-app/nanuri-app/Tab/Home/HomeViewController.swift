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
            make.bottom.equalToSuperview()
        }
        
        if UserDefaults.standard.integer(forKey: "userID") != 0 {
            Networking.sharedObject.getUserInfo(userID: UserDefaults.standard.integer(forKey: "userID")) { response in
                UserSingleton.shared.userData = response
            }
        }
        
        // custom cell
//        let nibName = UINib(nibName: XibName.productCustomCell, bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: "cell")
        
        // bar item
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let url = "http://20.196.209.221:8000/products/"
        AF.request(url, method: .get).responseDecodable(of: Products.self) { response in
            switch response.result {
            case .success(_):
                guard let response = response.value else { return }
                self.products = response.products
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
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

        let product = products.reversed()[indexPath.row]
        
        let identifier = "\(indexPath.row) \(product.productId) \(product.joinPPLCnt)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = ProductCustomCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            cell.setUpView()
            if product.productImage == "banner1" {
                cell.productIamge.image = UIImage(named: "banner1")
            } else {
                let blobName = product.productImage
                let blobImage = AZBlobImage(containerName: "nanuriproductimgs")
                DispatchQueue.main.async {
                    blobImage.downloadImage(blobName: blobName, imageView: cell.productIamge) { _ in
                    }
                    cell.productIamge.snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.leading.trailing.equalToSuperview()
                        make.height.equalTo(122)
                    }
                    cell.productIamge.contentMode = .scaleAspectFill
                }
    
            }
            
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

        let product = products.reversed()[indexPath.row]
        productDetailVC.productID = product.productId
        productDetailVC.product = product
        productDetailVC.productUserID = product.userID
        
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    
}
