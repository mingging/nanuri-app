//
//  Extension.swift
//  nanuri-app
//
//  Created by minimani on 2021/12/25.
//

import Foundation

extension DateFormatter {
    func formatter(date: String) -> String {
        self.dateFormat = "yyyy-MM-dd"
        
        let convertDate = self.date(from: date)
        
//        let myDateFormatter = DateFormatter()
        self.dateFormat = "yyyy.MM.dd" // 2020년 08월 13일 오후 04시 30분
        let convertStr = self.string(from: convertDate!)
        
        return convertStr
    }
}

extension NumberFormatter {
    func priceFormatter(price: Int) -> String {
        self.numberStyle = .decimal
        let result = self.string(for: price)!
        
        return "\(result)원"
    }
}

func calculateDay(endDate: String) -> String {
    let nowDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let convertDate = dateFormatter.date(from: endDate)
    
    let day = Calendar.current.dateComponents([.day], from: nowDate, to: convertDate!)

    return "\(day.day!)"
}
