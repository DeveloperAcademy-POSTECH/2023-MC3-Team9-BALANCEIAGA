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
}
