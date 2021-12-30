//
//  MyPageViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/29.
//

import UIKit

class MyPageViewController: HeaderViewController {
    
    let nameLabel = UILabel()
    let addProductListButton = UIButton()
    let payProductListButton = UIButton()
    let tableView = UITableView()

    
    var productList: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        guard let data = UserSingleton.shared.userData else { return }
        Networking.sharedObject.getUserInfo(userID: data.user.userID) { response in
            UserSingleton.shared.userData = response
            self.productList = response.orders
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        payProductListButton.backgroundColor = UIColor(hex: Theme.primary)
        payProductListButton.setTitleColor(.white, for: .normal)
        addProductListButton.backgroundColor = .white
        addProductListButton.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func selectAddProductListButton() {
        guard let data = UserSingleton.shared.userData else { return }
        addProductListButton.backgroundColor = UIColor(hex: Theme.primary)
        addProductListButton.setTitleColor(.white, for: .normal)
        payProductListButton.backgroundColor = .white
        payProductListButton.setTitleColor(.black, for: .normal)
        
        productList = data.user.products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func selectPayProductListButton() {
        guard let order = UserSingleton.shared.userData else { return }
        payProductListButton.backgroundColor = UIColor(hex: Theme.primary)
        payProductListButton.setTitleColor(.white, for: .normal)
        addProductListButton.backgroundColor = .white
        addProductListButton.setTitleColor(.black, for: .normal)
        
        productList = order.orders
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func logoutAction() {
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { action in
            UserDefaults.standard.removeObject(forKey: "userID")
            let loginView = UIStoryboard(name: "Login", bundle: nil)
            guard let loginVC = loginView.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUpData() {
        guard let data = UserSingleton.shared.userData else { return }
        nameLabel.attributedText = NSAttributedString(string: data.user.userNick)
        
        productList = data.orders
    }
    
    func setUpView() {
        let profileView = UIView()
        self.view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(105)
        }
        
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "profilBadge")
        profileView.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(40)
            make.width.height.equalTo(57)
        }
        
        let levelLabel = UILabel()
        levelLabel.attributedText = NSAttributedString(string: "내 레벨 :")
        levelLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 9)
        profileView.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.leading.equalTo(profileImage.snp.trailing).inset(-13)
        }
        
        let levelBadge = UIImageView()
        levelBadge.image = UIImage(named: "levelBadge")
        profileView.addSubview(levelBadge)
        levelBadge.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(33)
            make.leading.equalTo(levelLabel.snp.trailing).inset(-4)
        }
        
      
        nameLabel.attributedText = NSAttributedString(string: "프로자취러")
        nameLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 18)
        nameLabel.textColor = UIColor(hex: Theme.primary)
        profileView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).inset(-5)
            make.leading.equalTo(profileImage.snp.trailing).inset(-13)
        }
        
        let editLabel = UIButton()
        editLabel.setAttributedTitle(NSAttributedString(string: "프로필 수정하기"), for: .normal)
        editLabel.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 9)
        editLabel.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
        profileView.addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.centerY.equalToSuperview()
        }


        let editImage = UIImageView()
        editImage.image = UIImage(named: "profilEditPencil")
        profileView.addSubview(editImage)
        editImage.snp.makeConstraints { make in
            make.trailing.equalTo(editLabel.snp.leading).inset(-2)
            make.centerY.equalToSuperview()
        }
        
        let logoutButton = UIButton()
        logoutButton.setAttributedTitle(NSAttributedString(string: "로그아웃"), for: .normal)
        logoutButton.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 9)
        logoutButton.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
        profileView.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7)
            make.trailing.equalToSuperview().inset(10)
        }
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        let buttonView = UIView()
        self.view.addSubview(buttonView)
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = UIColor(hex: "#E5E5E5ff")?.cgColor
        
       
        payProductListButton.setAttributedTitle(NSAttributedString(string: "내가 구매한 상품"), for: .normal)
        payProductListButton.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 13)
        payProductListButton.backgroundColor = UIColor(hex: Theme.primary)
        payProductListButton.setTitleColor(.white, for: .normal)
        buttonView.addSubview(payProductListButton)
        payProductListButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        payProductListButton.addTarget(self, action: #selector(selectPayProductListButton), for: .touchUpInside)
       
        addProductListButton.setAttributedTitle(NSAttributedString(string: "내가 등록한 상품"), for: .normal)
        addProductListButton.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 13)
        buttonView.addSubview(addProductListButton)
        addProductListButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        addProductListButton.addTarget(self, action: #selector(selectAddProductListButton), for: .touchUpInside)
        
        buttonView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
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

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let productList = productList {
            return productList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let productList = productList else { return UITableViewCell() }
        let product = productList[indexPath.row]
        
        let identifier = "\(product.productId) \(indexPath.row)"
        
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
              let products = productList
        else { return }

        let product = products[indexPath.row]
        productDetailVC.productID = product.productId
        productDetailVC.product = product
        productDetailVC.productUserID = product.userID
        
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    
}
