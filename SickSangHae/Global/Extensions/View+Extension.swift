//
//  View_Extension.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/24.
//

import SwiftUI

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil, from: nil, for: nil)
  }
}
