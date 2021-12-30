//
//  AddProductViewController.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/03.
//

import UIKit
import SnapKit
import Alamofire
import PhotosUI

class AddProductViewController: UIViewController {
    let containerName = "nanuriproductimgs"
    let connectionString:String = "DefaultEndpointsProtocol=https;AccountName=logvieoblobimgs;AccountKey=LmiLJOBXGakx9UodRVLenmDyg8aoRDWabfKIyO28rTOHMRptZVH2oooHj0TEOGKQwwxDWrmcaa2/N/apD3e2wg==;EndpointSuffix=core.windows.net"
    
    let imageUploadView = UIImageView()
    var deliveryMethod = "배송"
    var category = ["음식","생활용품","주방", "욕실", "문구", "기타"]
    
    
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
    let categoryTextField = UITextField()
    let detailContents = UITextView()
    let datePicker = UIDatePicker()
    let picker = UIPickerView()


    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.setDate(Date(), animated: true)
        viewSetUp()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        productNameTextField.underlineTextField()
        productLinkTextField.underlineTextField()
        productPriceTextField.underlineTextField()
        recruitmentTextField.underlineTextField()
        periodTextField.underlineTextField()
        categoryTextField.underlineTextField()
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
            detailContents.text.isEmpty ||
            categoryTextField.text!.isEmpty {
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
        var imageName = ""
        guard let productName = productNameTextField.text,
              let productLink = productLinkTextField.text,
              let productPrice = productPriceTextField.text,
              let recruitment = recruitmentTextField.text,
              let period = periodTextField.text,
              let detailContents = detailContents.text,
              let category = categoryTextField.text,
              let userData = UserSingleton.shared.userData
        else { return }
        
        /*Azure Blob Image Upload*/
        if imageUploadView.image == nil{
            imageName = "banner1"
            imageUploadView.image = UIImage(named:imageName)

        } else {
            imageName = ProcessInfo.processInfo.globallyUniqueString
            let blobImage =  AZBlobImage(containerName: containerName)
            if let image = imageUploadView.image{
                if let data = image.jpegData(compressionQuality: 0.3){
                    blobImage.uploadData(data: data, blobName: imageName)
                }
            }
        }
        
        let price = Int(productPrice)
        let total = Int(recruitment)
        let categoryID = CategorySingleton.shared.categoryToID(category: category)
        
        let url = "http://20.196.209.221:8000/products/"
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let parameters = [
            "product_name": productName,
            "link": productLink,
            "product_image": imageName,
            "product_price": price ?? 0,
            "total_ppl_cnt": total ?? 0,
            "end_date": period,
            "delivery_method": deliveryMethod,
            "detail_content": detailContents,
            "user_id": userData.user.userID,
            "category_id": categoryID,
        ] as [String : Any]
        
        AF.upload(multipartFormData: { (multiFormData) in
                for (key, value) in parameters {
                    multiFormData.append(Data("\(value)".utf8), withName: key)
                }
        }, to: url, headers: header).responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("sucess reponse is :\(response)")
                    
                    let alert = UIAlertController(title: "나누리", message: "상품 등록이 완료되었습니다!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "확인", style: .default) { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
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
    
    @objc func donePressed() {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        
        periodTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func actGetImage(_ sender: Any) {
        present(photoPicker, animated: true)
    }
    
    func userSelectedPhoto(_ image: UIImage){
        // 이미지 피커 didFinish 선택한 이미지를 이미지뷰에 업데이트, 모델 호출, 레이블 적용
        DispatchQueue.main.async {
            // 메인 스레드에서 이미지 업데이트
            self.imageUploadView.image = image
        }
        
    }
    
    func createDatePickerView() {
       let toolbar = UIToolbar()
       toolbar.sizeToFit()
       
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donePressed))
       toolbar.setItems([doneButton], animated: true)
        
        var components = DateComponents()
        components.month = 3
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())

        datePicker.minimumDate = Date()
        datePicker.maximumDate = maxDate
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.timeZone = .autoupdatingCurrent
       datePicker.preferredDatePickerStyle = .wheels
       datePicker.datePickerMode = .date
       
       periodTextField.inputAccessoryView = toolbar
        periodTextField.inputView = datePicker
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
        productNameTextField.underlineTextField()
        productNameTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)

        
        
        // upload imageView
        
        stepOneView.addSubview(imageUploadView)
        imageUploadView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productNameTextField.snp.bottom).inset(-50)
            make.height.equalTo(131)
        }
        imageUploadView.backgroundColor = .gray
        //image upload Button
        let uploadBtn = UIButton()
        stepOneView.addSubview(uploadBtn)
        uploadBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productNameTextField.snp.bottom).inset(-50)
            make.height.equalTo(131)
        }
        uploadBtn.addTarget(self, action: #selector(actGetImage), for: .touchUpInside)
        uploadBtn.setTitle("이미지 업로드", for: .normal)
        uploadBtn.backgroundColor = .gray.withAlphaComponent(0.3)
        
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
        productLinkTextField.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        productLinkTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)

        
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
        productPriceTextField.keyboardType = .numberPad
        productPriceTextField.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        productPriceTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)


        
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
        recruitmentTextField.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
        recruitmentTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)

        
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
        periodTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        periodTextField.borderStyle = .line
        createDatePickerView()
        periodTextField.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor

        
        periodSubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(periodTextField.snp.bottom).inset(-6)
        }
        periodSubLabel.text = "MAX 3개월"
        periodSubLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 10)
        periodSubLabel.textColor = .gray
    
        
        // category
        let categoryLabel = UILabel()
        
        stepTwoView.addSubview(categoryLabel)
        stepTwoView.addSubview(categoryTextField)

        categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(periodTextField.snp.bottom).inset(-50)
        }
        categoryLabel.text = "카테고리"
        categoryLabel.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        
        categoryTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).inset(-12)
            make.height.equalTo(33)
        }
        categoryTextField.font = UIFont(name: "NanumSquareRoundOTFR", size: 15)
        picker.delegate = self
        picker.dataSource = self
        categoryTextField.inputView = picker
        
        configToolbar()
        
        // delivery
        let deliveryLabel = UILabel()
        deliverySegment.addTarget(self, action: #selector(selectDeliverySegment), for: .valueChanged)
        
        stepTwoView.addSubview(deliveryLabel)
        stepTwoView.addSubview(deliverySegment)
        
        deliveryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryTextField.snp.bottom).inset(-50)
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
        detailContents.layer.borderColor = UIColor(hex: Theme.primary)?.cgColor
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



//MARK: - UIPickerViewDelegate

extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func configToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donePicker))
        doneButton.tintColor = .black
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.cancelPicker))
        cancelButton.tintColor = .black
        
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        categoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        let row = self.picker.selectedRow(inComponent: 0)
        self.picker.selectRow(row, inComponent: 0, animated: false)
        self.categoryTextField.text = self.category[row]
        self.categoryTextField.resignFirstResponder()
    }
    
    @objc func cancelPicker() {
        self.categoryTextField.text = nil
        self.categoryTextField.resignFirstResponder()
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return category[row]
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryTextField.text = self.category[row]
        
    }

}

extension AddProductViewController: PHPickerViewControllerDelegate {
    var photoPicker: PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let photoPicker = PHPickerViewController(configuration: config)
        photoPicker.delegate = self
        
        return photoPicker
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: false)
        
        guard let result = results.first else {
            return
        }
        result.itemProvider.loadObject(ofClass: UIImage.self) { object, Error in
            if let photo = object as? UIImage {
                self.userSelectedPhoto(photo)
            }
        }
    }
}
