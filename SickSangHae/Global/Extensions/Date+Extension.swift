//
//  Date+Extension.swift
//  SickSangHae
//
//  Created by user on 2023/07/20.
//

import Foundation

extension Date {
    var dateDifference: Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date.now).day ?? 0
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: self)
    }
    
    var remainingDate: String {
        let threeMonthInSeconds = 7889400
        let dateDifference = Calendar.current.dateComponents([.day], from: .now, to: self + TimeInterval(threeMonthInSeconds)).day
        return String(dateDifference ?? 90)
    }
}
