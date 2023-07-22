//
//  TopAlertView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

//MARK: - 색, 폰트 변경

struct TopAlertView: ViewModifier {
  var iconImage: String
  var message: String
  var backgroundColor: Color
  @State private var isAlertVisible = true
  
  func body(content: Content) -> some View {
    if isAlertVisible {
      ZStack(alignment: .leading) {
        backgroundColor
        HStack(spacing: 14.adjusted) {
          Image(iconImage)
            .resizable()
            .frame(width: 40.adjusted, height: 40.adjusted)
            .scaledToFit()
          VStack(spacing: 4.adjusted) {
            Text(message)
              .font(.system(size: 14).bold())
              .foregroundColor(.white)
            Text("눌러서 실행 취소")
              .font(.system(size: 12))
              .foregroundColor(.gray)
          }
        }
        .frame(width: 348.adjusted, height: 68.adjusted)
        .background(.regularMaterial)
        .cornerRadius(41.adjusted)
      }
      .animation(.easeInOut)
      .gesture (DragGesture()
        .onChanged { value in
          if value.translation.height < -50 {
            withAnimation {
              isAlertVisible = false
            }
          }
        }
      )
    }
  }
}
