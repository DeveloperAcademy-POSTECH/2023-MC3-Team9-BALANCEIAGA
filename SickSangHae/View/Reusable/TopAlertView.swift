//
//  TopAlertView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

//MARK: - 색, 폰트 변경

enum TopAlertViewCase {
  case delete
  case rot
  case eat
}

struct TopAlertView: View {
  var name: String
  var currentCase: TopAlertViewCase = .delete

  var body: some View {
    switch currentCase {
    case .delete:
      TopAlertBaseView(iconImage: "img_delete", message: "\(name)를 삭제했어요", backgroundColor: .red)
    case .rot:
      TopAlertBaseView(iconImage: "img_rot", message: "\(name)가 상했어요", backgroundColor: .red)
    case .eat:
      TopAlertBaseView(iconImage: "img_eat", message: "\(name)를 먹었어요", backgroundColor: .green)
  
    }
  }
}

struct TopAlertBaseView: View {
  var iconImage: String
  var message: String
  var backgroundColor: Color
  @State private var isAlertVisible = true
  @GestureState private var dragOffset = CGSize.zero

  var body: some View {
    if isAlertVisible {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 41.adjusted)
          .stroke(backgroundColor, lineWidth: 1)
          .background(.regularMaterial)
          .background(backgroundColor)
          .opacity(0.7)
          .frame(width: 348.adjusted, height: 68.adjusted)
          .clipShape(RoundedRectangle(cornerRadius: 41.adjusted))
        HStack(spacing: 10.adjusted) {
          Image(iconImage)
            .resizable()
            .scaledToFill()
            .frame(width: 44.adjusted, height: 44.adjusted)
          VStack(alignment: .leading, spacing: 4.adjusted) {
            Text(message)
              .font(.system(size: 14).bold())
              .foregroundColor(.black)
            Text("눌러서 실행 취소")
              .font(.system(size: 12))
              .foregroundColor(.gray)
          }
        }
        .padding(.leading, 14.adjusted)
      }
      .animation(.easeInOut)
      .offset(y: max(dragOffset.height, 0))
      .gesture (DragGesture()
        .updating($dragOffset, body: { (value, dragOffset, _) in
          dragOffset = value.translation
        })
        .onEnded { value in
          if value.translation.height < -50 {
            withAnimation {
              isAlertVisible = false
            }
          }
        })
    }
  }
}


struct TopAlertView_Previews: PreviewProvider {
    static var previews: some View {
      TopAlertView(name: "파채", currentCase: .delete)

    }
}
