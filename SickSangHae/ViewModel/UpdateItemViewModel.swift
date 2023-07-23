//
//  UpdateItemViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/24.
//

import SwiftUI

class UpdateItemViewModel: ObservableObject {
  @Published var date = Date()
  @Published var todayDate = Date()
  @Published var isDatePickerOpen = false
  
  static let dateFormat: DateFormatter =  {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월 dd일"
    return formatter
  }()
  
  func decreaseDate() {
      date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
  }
  
  func increaseDate() {
      if date < todayDate {
          date = Calendar.current.date(byAdding: .day, value: +1, to: date) ?? date
      }
  }
}

