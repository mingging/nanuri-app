//
//  ProductDetailViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/15.
//

import UIKit

import Alamofire
import SnapKit

class ProductDetailViewController: UIViewController {
    
    //MARK: - Property
    let textView = UITextView()
    let scrollView = UIScrollView()
    let productLinkButton = UIButton()
    let categoryLabel = UILabel()
    let productNameLabel = UILabel()
    let productPriceLabel = UILabel()
    let periodLabel = UILabel()
    let recruitmentLabel = UILabel()
    let dDayLabel = UILabel()
    let deliveryLabel = UILabel()
    let nicNameLabel = UILabel()
    let commentButton = UIButton()
    let footerButton = UIButton()

    var productID: Int?
    var productUserID: Int?
    var product: Product?
    let category = ["", "음식", "생활용품", "주방", "욕실", "문구", "기타"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        CategorySingleton.shared.categoryToString(categoryID: 1)
        viewSetUp()
        setUpData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
    }
    
    @objc func selectProductLinkButton() {
        print("click")
        guard let product = product,
              let url = URL(string: product.link),
                UIApplication.shared.canOpenURL(url)
        else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setUpData() {
        guard let product = product else { return }
        
        categoryLabel.text = "# \(category[product.categoryID])"
        productNameLabel.text = product.productName
        productPriceLabel.text = NumberFormatter().priceFormatter(price: product.productPrice)
        periodLabel.text = "\(DateFormatter().formatter(date: product.startDate)) ~ \(DateFormatter().formatter(date: product.endDate))"
        recruitmentLabel.text = "\(product.joinPPLCnt) / \(product.totalPPLCnt)명"
        dDayLabel.text = "D - \(calculateDay(endDate: product.endDate))"
        deliveryLabel.text = product.deliveryMethod
        
        Networking.sharedObject.getUserInfo(userID: product.userID) { response in
            self.nicNameLabel.text = response.user.userNick
        }
        
        let attributedString = NSMutableAttributedString(string: product.detailContent)
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        textView.attributedText = attributedString
        
        guard let userData = UserSingleton.shared.userData,
              let productUserID = productUserID
        else { return }
        if userData.userID == productUserID {
            footerButton.setAttributedTitle(NSAttributedString(string: "이미 참여중입니다."), for: .normal)
            footerButton.isEnabled = false
            footerButton.backgroundColor = .lightGray
        }

    }
    
    @objc func goToComment() {
        print("click")
        let commentView = UIStoryboard(name: Stoyboard.comment.name, bundle: nil)
        guard let commentVC = commentView.instantiateViewController(withIdentifier: Stoyboard.comment.id) as? CommentViewController else { return }
        
        navigationController?.pushViewController(commentVC, animated: true)
    }
    
    @objc func nextAction() {
        let payView = UIStoryboard(name: Stoyboard.pay.name, bundle: nil)
        guard let payVC = payView.instantiateViewController(withIdentifier: Stoyboard.pay.id) as? PayViewController,
                let product = product
        else { return }
        
        payVC.productName = product.productName
        payVC.productPrice = product.productPrice
        payVC.method = product.deliveryMethod
        
        navigationController?.pushViewController(payVC, animated: true)
    }
    
    //MARK: - View Set Up
    func viewSetUp() {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 65)
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height + 210)
        self.view.addSubview(scrollView)
        
        // header
        let headerImage = UIImageView()
        scrollView.addSubview(headerImage)
        
        headerImage.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.height.equalTo(250)
        }
        headerImage.image = UIImage(named: "image_sample")
        headerImage.contentMode = .scaleAspectFill
        
        // product link button
        scrollView.addSubview(productLinkButton)
        
        productLinkButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.view).inset(20)
            make.bottom.equalTo(headerImage.snp.bottom).inset(20)
        }
        productLinkButton.setImage(UIImage(named: "product_link_button"), for: .normal)
        productLinkButton.addTarget(self, action: #selector(selectProductLinkButton), for: .touchUpInside)
        
        // contents
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(30)
            make.top.equalTo(headerImage.snp.bottom).inset(-16)
        }
        
        // category
        
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        categoryLabel.text = "# 생활 용품"
        categoryLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 13)
        categoryLabel.textColor = UIColor(hex: Theme.secondary)
        
        // productName
        
        contentView.addSubview(productNameLabel)
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).inset(-6)
            make.width.lessThanOrEqualTo(211)
        }
        productNameLabel.text = "마이쭈가 좋아하는 마이쮸"
        productNameLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 20)
        productNameLabel.numberOfLines = 2
        productNameLabel.textColor = UIColor(hex: Theme.primary)
                                    
        // productPrice
        contentView.addSubview(productPriceLabel)
        
        productPriceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).inset(-6)
            make.leading.equalTo(productNameLabel.snp.trailing)
        }
        productPriceLabel.text = "12,500원"
        productPriceLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 20)
        productPriceLabel.textAlignment = .right
        
        // period
        contentView.addSubview(periodLabel)
        
        periodLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(productNameLabel.snp.bottom).inset(-6)
        }
        periodLabel.text = "2021.11.09 ~ 2021.11.15"
        periodLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        periodLabel.textColor = UIColor(hex: Theme.lightGray)
        
        // recruitment
      
        contentView.addSubview(recruitmentLabel)
        
        recruitmentLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(productPriceLabel.snp.bottom).inset(-6)
            make.leading.equalTo(periodLabel.snp.trailing)
        }
        recruitmentLabel.text = "2 / 5명"
        recruitmentLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 15)
        recruitmentLabel.textColor = UIColor(hex: Theme.lightGray)
        
        // dday
        let dDayView = UIView()
        contentView.addSubview(dDayView)
        
        dDayView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(52)
            make.top.equalTo(periodLabel.snp.bottom).inset(-6)
        }
        dDayView.backgroundColor = UIColor(hex: Theme.primary)
        dDayView.layer.cornerRadius = 5
        
        dDayView.addSubview(dDayLabel)
        
        dDayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        dDayLabel.text = "D - 6"
        dDayLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 13)
        dDayLabel.textColor = UIColor(hex: Theme.secondary)
        
        // delivery
        let deliveryView = UIView()
        contentView.addSubview(deliveryView)
        
        deliveryView.snp.makeConstraints { make in
            make.leading.equalTo(dDayView.snp.trailing).inset(-6)
            make.height.equalTo(25)
            make.width.equalTo(52)
            make.top.equalTo(periodLabel.snp.bottom).inset(-6)
        }
        deliveryView.backgroundColor = UIColor(hex: Theme.secondary)
        deliveryView.layer.cornerRadius = 5
        
        deliveryView.addSubview(deliveryLabel)
        
        deliveryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        deliveryLabel.text = "배송"
        deliveryLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 13)
        deliveryLabel.textColor = UIColor(hex: Theme.primary)
        
       // detailContents
        let processLabel = UILabel()
        contentView.addSubview(processLabel)
        
        processLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryView.snp.bottom).inset(-16)
            make.leading.equalToSuperview()
        }
        processLabel.text = "진행 방법"
        processLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        
        // comment & favorite
        let favoriteButton = UIButton()
        
        contentView.addSubview(commentButton)
        contentView.addSubview(favoriteButton)
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(deliveryView.snp.bottom).inset(-9)
            make.trailing.equalToSuperview()
            make.leading.equalTo(favoriteButton.snp.trailing).inset(12)
        }
        commentButton.setImage(UIImage(named: "chat_icon"), for: .normal)
        commentButton.addTarget(self, action: #selector(goToComment), for: .touchUpInside)

        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(deliveryView.snp.bottom).inset(-9)
            make.trailing.equalTo(commentButton.snp.leading).inset(-12)
        }
        favoriteButton.setImage(UIImage(named: "heart_fill"), for: .normal)
        
        // hr
        let separateView = UIView()
        contentView.addSubview(separateView)
        
        separateView.snp.makeConstraints { make in
            make.top.equalTo(processLabel.snp.bottom).inset(-8)
            make.trailing.left.equalToSuperview()
            make.height.equalTo(1)
        }
        separateView.backgroundColor = .systemGray5
        
        // owner
        let ownerLabel = UILabel()
        let levelImage = UIImageView()
        
        contentView.addSubview(ownerLabel)
        contentView.addSubview(levelImage)
        contentView.addSubview(nicNameLabel)
        
        nicNameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(separateView.snp.bottom).inset(-7)
        }
        nicNameLabel.text = "프로자취러"
        nicNameLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        
        levelImage.snp.makeConstraints { make in
            make.trailing.equalTo(nicNameLabel.snp.leading).inset(-2)
            make.top.equalTo(separateView.snp.bottom).inset(-7)
        }
        levelImage.image = UIImage(named: "levelBadge")
        
        ownerLabel.snp.makeConstraints { make in
            make.trailing.equalTo(levelImage.snp.leading).inset(-2)
            make.top.equalTo(separateView.snp.bottom).inset(-7)
        }
        ownerLabel.text = "작성자 : "
        ownerLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 12)
        ownerLabel.textColor = UIColor(hex: Theme.lightGray)
        
        // textView
      
        contentView.addSubview(textView)

        textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(ownerLabel.snp.bottom).inset(-15)
            make.bottom.equalToSuperview()
        }
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont(name: "NanumSquareRoundOTFR", size: 12)
        textView.attributedText = NSAttributedString(string: """
        로스팅 원두 배송합니다!
        코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

        가격은 배송비 포함해서 + 1000원이구요
        주문주실 때 주소 적어주세요!

        로스팅 원두 배송합니다!
        코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

        가격은 배송비 포함해서 + 1000원이구요 주문주실 때 주소 적어주세요!
        로스팅 원두 배송합니다!
        코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

        가격은 배송비 포함해서 + 1000원이구요 주문주실 때 주소 적어주세요!

        로스팅 원두 배송합니다!
        코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

        가격은 배송비 포함해서 + 1000원이구요 주문주실 때 주소 적어주세요!
        """)
//        textViewDidChange(textView)
        
        // footer
      
        self.view.addSubview(footerButton)
        footerButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(65)
        }
        footerButton.setTitle("공동 구매 참여 하기", for: .normal)
        footerButton.backgroundColor = UIColor(hex: Theme.primary)
        footerButton.titleLabel?.font = UIFont(name: "NanumSquareRoundOTFB", size: 18)
        footerButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(footerButton.snp.top)
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


//MARK: - TextViewDelegate
//extension ProductDetailViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        let size = CGSize(width: view.frame.width, height: .infinity)
//        let estimateSize = textView.sizeThatFits(size)
//        print(estimateSize.height)
//
//        textView.snp.updateConstraints { make in
//            make.height.equalTo(estimateSize.height)
//        }
//    }
//}
