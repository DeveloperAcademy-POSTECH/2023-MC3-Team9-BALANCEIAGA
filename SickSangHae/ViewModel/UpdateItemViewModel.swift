//
//  UpdateItemViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/24.
//

import SwiftUI

//MARK: - CalendarViewModel로 이름 변경 필요, monthFormatter 필요
final class UpdateItemViewModel: ObservableObject {
  @Published var date = Date()
  @Published var isDatePickerOpen = false
  @Published var isShowTextfieldWarning = false
  @Published var isShowTopAlertView = false
  @Published var priceInt: Int = 0
  @Published var priceString: String = ""
  @Published var name: String = ""
  
  
  private static let dateFormat: DateFormatter =  {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY년 M월 dd일"
    return formatter
  }()
  
  static let priceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = ","
    formatter.positiveSuffix = "원"
    return formatter
  }()
  
  var showTextfieldStatus: String {
    switch (priceString.isEmpty, name.isEmpty) {
    case (true, true):
      return "상품명과 금액"
    case (true, false):
      return "금액"
    case (false, true):
      return "상품명"
    case (false, false):
      return ""
    }
  }
  
  var isAnyTextFieldEmpty: Bool {
    return name.isEmpty || priceString.isEmpty
  }
  
  var areBothTextFieldsNotEmpty: Bool {
    return !name.isEmpty && !priceString.isEmpty
  }
  
  var todayDate: Date {
    return Calendar.current.startOfDay(for: Date())
  }
  
  var dateString: String {
    UpdateItemViewModel.dateFormat.string(from: date)
  }
  
  var isDateBeforeToday: Bool {
    return date < todayDate
  }
  
  var decreaseDate: Date {
    get {
      return date
    }
    set {
      date = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? date
    }
  }
  
  var increaseDate: Date {
    get {
      return date
    }
    set {
      if newValue < todayDate {
        date = Calendar.current.date(byAdding: .day, value: +1, to: date) ?? date
      }
    }
  }
}

