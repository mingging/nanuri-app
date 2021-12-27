//
//  AddProductViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/03.
//

import UIKit
import SnapKit
import Alamofire

class AddProductViewController: UIViewController {
    
    var deliveryMethod = "배송"
    
    //MARK: - Step View Property
    let stepView = UIView()
    let oneButton = UIButton()
    let twoButton = UIButton()
    let footerButton = UIButton()
    let submitButton = UIButton()
    
    //MARK: - StepOneView Property
    let stepOneView = UIView()
    let productNameTextField = UITextField()
    let productLinkTextField = UITextField()
    let productPriceTextField = UITextField()
    
    //MARK: - StepTwoView Property
    let stepTwoScrollView = UIScrollView()
    let recruitmentTextField = UITextField()
    let periodTextField = UITextField()
    let deliverySegment = UISegmentedControl(items: ["배송", "직거래"])
    let detailContents = UITextView()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true // 뷰 컨트롤러가 나타날 때 숨기기
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false // 뷰 컨트롤러가 사라질 때 나타내기
    }
    
    @objc func selectDeliverySegment() {
        if deliverySegment.selectedSegmentIndex == 0 {
            deliveryMethod = "배송"
        } else {
            deliveryMethod = "직거래"
        }
    }
    
    func validation() -> Bool {
        if productNameTextField.text!.isEmpty ||
            productLinkTextField.text!.isEmpty ||
            productPriceTextField.text!.isEmpty ||
            recruitmentTextField.text!.isEmpty ||
            periodTextField.text!.isEmpty ||
            detailContents.text.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    @objc func selectFooterButton() {
        print("click")
        guard validation() else {
            return
        }
        setProduct()
    }
    
    func setProduct() {
        guard let productName = productNameTextField.text,
              let productLink = productLinkTextField.text,
              let productPrice = productPriceTextField.text,
              let recruitment = recruitmentTextField.text,
              let period = periodTextField.text,
              let detailContents = detailContents.text
        else { return }
        
        let price = Int(productPrice)
        let total = Int(recruitment)
        
        let url = "http://20.196.209.221:8000/products/"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let parameters = [
            "product_name": productName,
            "link": productLink,
            "product_image": "imageName",
            "product_price": price ?? 0,
            "total_ppl_cnt": total ?? 0,
            "end_date": period,
            "delivery_method": deliveryMethod,
            "detail_content": detailContents,
            "user_id": 1,
            "category_id": 2,
        ] as [String : Any]
        
        AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data("\(value)".utf8), withName: key)
                }
        }, to: url, headers: header).responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("sucess reponse is :\(response)")
                    self.navigationController?.popViewController(animated: true)
                case .failure(_):
                    print("fail")
                }
            }
        
    }
    
    
    @objc func showStepOne() {
        stepOneView.alpha = 1.0
        stepTwoScrollView.alpha = 0.0
        footerButton.alpha = 1.0
        submitButton.alpha = 0.0
        
        oneButton.backgroundColor = UIColor(hex: Theme.primary)
        oneButton.setTitleColor(.white, for: .normal)
        twoButton.backgroundColor = .white
        twoButton.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
    }
    
    @objc func showStepTwo() {
        stepOneView.alpha = 0.0
        stepTwoScrollView.alpha = 1.0
        footerButton.alpha = 0.0
        submitButton.alpha = 1.0
        
        twoButton.backgroundColor = UIColor(hex: Theme.primary)
        twoButton.setTitleColor(.white, for: .normal)
        oneButton.backgroundColor = .white
        oneButton.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
    }
    
    @objc func nextAction() {
        stepOneView.alpha = 0.0
        stepTwoScrollView.alpha = 1.0
        footerButton.alpha = 0.0
        submitButton.alpha = 1.0
        
        twoButton.backgroundColor = UIColor(hex: Theme.primary)
        twoButton.setTitleColor(.white, for: .normal)
        oneButton.backgroundColor = .white
        oneButton.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
    }
    
    func viewSetUp() {
        self.view.addSubview(stepView)
        
        stepView.addSubview(oneButton)
        oneButton.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.leading.height.top.equalToSuperview()
        }
        oneButton.setTitle("1", for: .normal)
        oneButton.backgroundColor = UIColor(hex: Theme.primary)
        oneButton.addTarget(self, action: #selector(showStepOne), for: .touchUpInside)
        
      
        stepView.addSubview(twoButton)
        twoButton.snp.makeConstraints { make in
            make.width.equalTo(165)
            make.leading.equalTo(oneButton.snp.trailing)
            make.trailing.height.top.equalToSuperview()
        }
        twoButton.setTitle("2", for: .normal)
        twoButton.backgroundColor = .white
        twoButton.setTitleColor(UIColor(hex: Theme.primary), for: .normal)
        twoButton.addTarget(self, action: #selector(showStepTwo), for: .touchUpInside)

        
        stepView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(30)
        }
        
        stepOneViewSetUp()
        stepTwoViewSetUp()
        
        stepOneView.alpha = 1.0
        stepTwoScrollView.alpha = 0.0
        footerButton.alpha = 1.0
        submitButton.alpha = 0.0
        
       
        self.view.addSubview(footerButton)
        self.view.addSubview(submitButton)
        
        footerButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(65)
        }
        footerButton.setTitle("다음", for: .normal)
        footerButton.backgroundColor = UIColor(hex: Theme.primary)
        footerButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        submitButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(65)
        }
        submitButton.setTitle("등록하기", for: .normal)
        submitButton.backgroundColor = UIColor(hex: Theme.primary)
        submitButton.addTarget(self, action: #selector(selectFooterButton), for: .touchUpInside)
        
       
        
    }
    
    func stepOneViewSetUp() {
       
        self.view.addSubview(stepOneView)
        
        stepOneView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.top).inset(60)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        // productName
        let productNameLabel = UILabel()
       
        
        stepOneView.addSubview(productNameLabel)
        stepOneView.addSubview(productNameTextField)
        
        productNameLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.top.equalToSuperview()
        }
        productNameLabel.text = "상품 이름"
        productNameLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        productNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productNameLabel.snp.bottom).inset(-12)
        }
        productNameTextField.borderStyle = .line
        
        
        // image upload
        let imageUploadView = UIView()
        stepOneView.addSubview(imageUploadView)
        imageUploadView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productNameTextField.snp.bottom).inset(-50)
            make.height.equalTo(131)
        }
        imageUploadView.backgroundColor = .gray
        
        // product link
        let productLinkLabel = UILabel()
       
        
        stepOneView.addSubview(productLinkLabel)
        stepOneView.addSubview(productLinkTextField)
        
        productLinkLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageUploadView.snp.bottom).inset(-50)
        }
        productLinkLabel.text = "상품 링크"
        productLinkLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)

        productLinkTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productLinkLabel.snp.bottom).inset(-12)
        }
        productLinkTextField.borderStyle = .line
        
        // product price
        let productPriceLabel = UILabel()
      
        let priceSubLabel = UILabel()
        
        stepOneView.addSubview(productPriceLabel)
        stepOneView.addSubview(productPriceTextField)
        stepOneView.addSubview(priceSubLabel)
        
        productPriceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productLinkTextField.snp.bottom).inset(-50)
        }
        productPriceLabel.text = "상품 가격"
        productPriceLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        productPriceTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productPriceLabel.snp.bottom).inset(-12)
        }
        productPriceTextField.borderStyle = .line
        
        priceSubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(productPriceTextField.snp.bottom).inset(-6)
        }
        priceSubLabel.text = "상품 가격이 결정되지 않은 경우 0으로 적어주세요!"
        priceSubLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 10)
        priceSubLabel.textColor = .gray
    }
    
    func stepTwoViewSetUp() {
        
        stepTwoScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        stepTwoScrollView.contentSize = CGSize(width: stepTwoScrollView.frame.width, height: stepTwoScrollView.frame.height)
        self.view.addSubview(stepTwoScrollView)
        stepTwoScrollView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.top).inset(60)
            make.trailing.leading.bottom.equalToSuperview()
        }
        stepTwoScrollView.showsVerticalScrollIndicator = true
        
       
        
        let stepTwoView = UIView()
        
        stepTwoScrollView.addSubview(stepTwoView)
        stepTwoView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).inset(30)
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        // recruitment
        let recruitmentLabel = UILabel()
      
        let recruitmentSubLabel = UILabel()
        
        stepTwoView.addSubview(recruitmentLabel)
        stepTwoView.addSubview(recruitmentTextField)
        stepTwoView.addSubview(recruitmentSubLabel)
        
        recruitmentLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.top.equalToSuperview()
        }
        recruitmentLabel.text = "모집 인원"
        recruitmentLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        recruitmentTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(recruitmentLabel.snp.bottom).inset(-12)
        }
        recruitmentTextField.borderStyle = .line
        
        recruitmentSubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(recruitmentTextField.snp.bottom).inset(-6)
        }
        recruitmentSubLabel.text = "MIN 1명"
        recruitmentSubLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 10)
        recruitmentSubLabel.textColor = .gray
        
        // recruitment period
        let periodLabel = UILabel()
       
        let periodSubLabel = UILabel()
        
        stepTwoView.addSubview(periodLabel)
        stepTwoView.addSubview(periodTextField)
        stepTwoView.addSubview(periodSubLabel)
        
        periodLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(recruitmentTextField.snp.bottom).inset(-50)
        }
        periodLabel.text = "모집 기간"
        periodLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        periodTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(periodLabel.snp.bottom).inset(-12)
        }
        periodTextField.borderStyle = .line
        
        periodSubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(periodTextField.snp.bottom).inset(-6)
        }
        periodSubLabel.text = "MAX 3개월"
        periodSubLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 10)
        periodSubLabel.textColor = .gray
        
        // category
        let categoryLabel = UILabel()
        let category = UIView()
        
        stepTwoView.addSubview(categoryLabel)
        stepTwoView.addSubview(category)

        categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(periodTextField.snp.bottom).inset(-50)
        }
        categoryLabel.text = "카테고리"
        categoryLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        category.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).inset(-12)
            make.height.equalTo(33)
        }
        category.backgroundColor = .gray
        
        // delivery
        let deliveryLabel = UILabel()
        deliverySegment.addTarget(self, action: #selector(selectDeliverySegment), for: .valueChanged)
        
        stepTwoView.addSubview(deliveryLabel)
        stepTwoView.addSubview(deliverySegment)
        
        deliveryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(category.snp.bottom).inset(-50)
        }
        deliveryLabel.text = "배송 방법"
        deliveryLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        deliverySegment.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(deliveryLabel.snp.bottom).inset(-12)
        }
        deliverySegment.selectedSegmentIndex = 0
        
        // detail contents
        let detailContentsLabel = UILabel()
        
        stepTwoView.addSubview(detailContentsLabel)
        stepTwoView.addSubview(detailContents)
        
        detailContentsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(deliverySegment.snp.bottom).inset(-50)
        }
        detailContentsLabel.text = "상세 내용 / 진행 방법"
        detailContentsLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        detailContents.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(detailContentsLabel.snp.bottom).inset(-12)
            make.height.greaterThanOrEqualTo(300)
        }
        detailContents.isEditable = true
        detailContents.layer.borderWidth = 1
        detailContents.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
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
