//
//  DateSingleton.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/29.
//

import Foundation
import UIKit

class Singleton {
    static let shared = Singleton()
    
    let backgroundView = UIView()
    let indicatorView = UIView()
    let indicator = UIActivityIndicatorView()
    
    func startLoading(_ view: UIView) {
        stopLoading()
        
        backgroundView.backgroundColor = .white
        view.addSubview(backgroundView)
        view.bringSubviewToFront(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicatorView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.addSubview(indicatorView)
        indicatorView.layer.cornerRadius = 5
        indicatorView.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.center.equalToSuperview()
        }
        
        indicator.style = .large
        indicator.color = .white
        indicatorView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        backgroundView.removeFromSuperview()
    }
}
