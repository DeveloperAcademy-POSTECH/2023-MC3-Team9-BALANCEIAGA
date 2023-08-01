//
//  TopAlertViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/23.
//

import SwiftUI

class TopAlertViewModel: ObservableObject {
    @Published var isAlertVisible = true
    
  var name: String
//  var currentCase: TopAlertViewCase
    var changedStatus: Status
    
  init(name: String, changedStatus: Status) {
    self.name = name
    self.changedStatus = changedStatus
  }
    
//    init(name: String, currentCase: TopAlertViewCase) {
//      self.name = name
//      self.currentCase = currentCase
//    }
  
  func hideAlert() {
    withAnimation {
      isAlertVisible = false
    }
  }
  
  // 제스처 종료(스와이프 완료) 처리를 수행하는 함수
  func onDragEnded(value: DragGesture.Value) {
    if value.translation.height < -80 {
      hideAlert()
    }
  }
}
