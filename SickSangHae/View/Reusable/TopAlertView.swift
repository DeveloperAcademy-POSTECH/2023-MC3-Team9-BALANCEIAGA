//
//  TopAlertView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

//MARK: - 색, 폰트 변경

struct TopAlertView: View {
  @ObservedObject var viewModel: TopAlertViewModel

  var body: some View {
    switch viewModel.currentCase {
    case .delete:
      TopAlertBaseView(iconImage: "img_delete", message: "\(viewModel.name)를 삭제했어요", backgroundColor: .pointRLight, strokeColor: .pointRMiddle, viewModel: viewModel)
    case .rot:
      TopAlertBaseView(iconImage: "img_rot", message: "\(viewModel.name)가 상했어요", backgroundColor: .pointRLight, strokeColor: .pointRMiddle, viewModel: viewModel)
    case .eat:
      TopAlertBaseView(iconImage: "img_eat", message: "\(viewModel.name)를 먹었어요", backgroundColor: .alertGreen, strokeColor: .primaryGMiddle, viewModel: viewModel)
  
    }
  }
}

struct TopAlertBaseView: View {
  var iconImage: String
  var message: String
  var backgroundColor: Color
  var strokeColor: Color
  @GestureState private var dragOffset = CGSize.zero
  @ObservedObject var viewModel: TopAlertViewModel

  var body: some View {
    if viewModel.isAlertVisible {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 41.adjusted)
          .stroke(strokeColor, lineWidth: 1)
          .background(backgroundColor)
          .background(.ultraThickMaterial)
          .frame(height: 68.adjusted)
          .clipShape(RoundedRectangle(cornerRadius: 41.adjusted))
          .opacity(0.8)
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
      .padding([.leading, .trailing], 20.adjusted)

      .animation(.easeInOut)
      .offset(y: max(dragOffset.height, 0))
      .gesture (DragGesture()
        .updating($dragOffset, body: { (value, dragOffset, _) in
           dragOffset = value.translation
         })
          .onEnded(viewModel.onDragEnded)
                
      )
    }
  }
}


struct TopAlertView_Previews: PreviewProvider {
    static var previews: some View {
      TopAlertView(viewModel: TopAlertViewModel(name: "파채", currentCase: .delete))
    }
}
