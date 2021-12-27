//
//  ProductCustomCell.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/27.
//

import UIKit

class ProductCustomCell: UITableViewCell {
    
    let productIamge = UIImageView()
    let productNameLabel = UILabel()
    let recruitmentLabel = UILabel()
    let priceLabel = UILabel()
    let periodLabel = UILabel()
    let progress = UIProgressView()
    let processPercentageLabel = UILabel()
    let dDayLabel = UILabel()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpView() {
        let productView = UIView()
        productView.backgroundColor = .white
        productView.layer.masksToBounds = false
        productView.layer.shadowColor = UIColor.black.cgColor
        productView.layer.shadowOpacity = Float(Style.shadowOpacity)
        productView.layer.shadowRadius = Style.radius
        productView.layer.cornerRadius = Style.radius
        productView.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentView.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(210)
            make.bottom.equalToSuperview()
        }
        
        productIamge.image = UIImage(named: "image_sample")
        productIamge.sizeToFit()
        productView.addSubview(productIamge)
        productIamge.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(122)
        }
        
        productNameLabel.attributedText = NSAttributedString(string: "로스팅 원두")
        productNameLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 15)
        productNameLabel.textColor = UIColor(hex: Theme.primary)
        productView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(productIamge.snp.bottom).inset(-22)
            make.leading.equalToSuperview().inset(13)
            make.width.lessThanOrEqualTo(218)
        }
        
        recruitmentLabel.attributedText = NSAttributedString(string: "2/5명")
        recruitmentLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 10)
        productView.addSubview(recruitmentLabel)
        recruitmentLabel.snp.makeConstraints { make in
            make.leading.equalTo(productNameLabel.snp.trailing).inset(-6)
            make.top.equalTo(productIamge.snp.bottom).inset(-25)
        }
        
        priceLabel.attributedText = NSAttributedString(string: "3,500원")
        priceLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 15)
        priceLabel.textAlignment = .right
        productView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productIamge.snp.bottom).inset(-22)
            make.trailing.equalToSuperview().inset(13)
            make.width.lessThanOrEqualTo(101)
        }
        
        periodLabel.attributedText = NSAttributedString(string: "2021.11.09 ~ 2021.11.15")
        periodLabel.font = UIFont(name: "NanumSquareRoundOTFB", size: 10)
        periodLabel.textColor = UIColor(hex: Theme.lightGray)
        productView.addSubview(periodLabel)
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(13)
        }
        
        progress.backgroundColor = UIColor(hex: "#E5E5E5ff")
        progress.tintColor = UIColor(hex: Theme.secondary)
        progress.progress = 0.5
        progress.layer.cornerRadius = Style.radius
        productView.addSubview(progress)
        progress.snp.makeConstraints { make in
            make.top.equalTo(periodLabel.snp.bottom).inset(-14)
            make.leading.trailing.equalToSuperview().inset(13)
        }
        
        processPercentageLabel.attributedText = NSAttributedString(string: "50%")
        processPercentageLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 10)
        processPercentageLabel.textColor = UIColor(hex: Theme.lightGray)
        productView.addSubview(processPercentageLabel)
        processPercentageLabel.snp.makeConstraints { make in
            make.bottom.equalTo(progress.snp.top).inset(-6)
            make.trailing.equalToSuperview().inset(13)
        }

        
        
        let dDayView = UIView()
        dDayView.layer.cornerRadius = Style.radius
        dDayView.layer.backgroundColor = UIColor(hex: Theme.primary)?.cgColor
        productView.addSubview(dDayView)
        
        
        dDayLabel.textColor = UIColor(hex: Theme.secondary)
        dDayLabel.attributedText = NSAttributedString(string: "D - 5")
        dDayLabel.font = UIFont(name: "NanumSquareRoundOTFEB", size: 13)
        dDayView.addSubview(dDayLabel)
        dDayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        dDayView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(14)
            make.width.equalTo(52)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
