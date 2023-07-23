//
//  customDatePickerView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/24.
//

import SwiftUI

struct CustomDatePickerView: View {
  @ObservedObject var viewModel: UpdateItemViewModel
  
  var body: some View {
    ZStack {
      Rectangle()
        .cornerRadius(12)
        .foregroundColor(.white)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
      
      GeometryReader { geo in
        DatePicker(
          viewModel.dateString,
          selection: $viewModel.date,
          in: ...Date(),
          displayedComponents: .date
        )
        .labelsHidden()
        .datePickerStyle(GraphicalDatePickerStyle())
        .frame(width: geo.size.width, height: geo.size.height)
        .onChange(of: viewModel.date) { _ in
          viewModel.isDatePickerOpen = false
        }
      }
      .padding(.all, 20)
    }
    .frame(height: screenHeight / (2.6).adjusted)
    .padding([.leading, .trailing], 14.adjusted)
  }
}

