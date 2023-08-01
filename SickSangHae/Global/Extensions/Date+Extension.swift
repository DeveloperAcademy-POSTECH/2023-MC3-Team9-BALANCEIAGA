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
        let dateTerm = DateComponents(day: 90)
        let dateTermFromNow = Calendar.current.date(byAdding: dateTerm, to: .now) ?? .now
        let dateDifference = Calendar.current.dateComponents([.day], from: self, to: dateTermFromNow).day
        return String(dateDifference ?? 90)
    }

    var formattedMonth: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M" // Format to display month and year
        return formatter.string(from: self)
    }

    func extractMonthNumber(from dateString: String) -> String? {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"

            if let date = formatter.date(from: dateString) {
                let calendar = Calendar.current
                let monthNumber = calendar.component(.month, from: date)
                return String(monthNumber)
            } else {
                return nil
            }
        }
}
