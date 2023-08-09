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
        switch viewModel.changedStatus {
        case .shortTermUnEaten:
            TopAlertBaseView(iconImage: "img_eat", message: "\"기본\" 보관으로 변경했어요", backgroundColor: .alertGreen, strokeColor: .primaryGMiddle, viewModel: viewModel)
        case .shortTermPinned:
            TopAlertBaseView(iconImage: "img_eat", message: "\"빨리 먹어야 해요\" 보관으로 변경했어요", backgroundColor: .alertGreen, strokeColor: .primaryGMiddle, viewModel: viewModel)
        case .longTermUnEaten:
            TopAlertBaseView(iconImage: "img_eat", message: "\"천천히 먹어도 돼요\" 보관으로 변경했어요", backgroundColor: .alertGreen, strokeColor: .primaryGMiddle, viewModel: viewModel)
        default:
            TopAlertBaseView(iconImage: "img_eat", message: "\(viewModel.name) 항목이 일반으로 이동됐어요", backgroundColor: .alertGreen, strokeColor: .primaryGMiddle, viewModel: viewModel)
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
          .background(Color.gray100)
          .background(.ultraThickMaterial)
          .frame(height: 68.adjusted)
          .clipShape(RoundedRectangle(cornerRadius: 41.adjusted))
          .opacity(0.8)
        HStack(spacing: 10.adjusted) {
            Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundColor(.primaryGB)
            .scaledToFill()
            .frame(width: 44.adjusted, height: 44.adjusted)
          VStack(alignment: .leading, spacing: 4.adjusted) {
            Text(message)
                  .font(.pretendard(.bold, size: 14))
              .foregroundColor(.black)
          }
        }
        .padding(.leading, 14.adjusted)
      }
      .padding([.leading, .trailing], 20.adjusted)
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
        TopAlertView(viewModel: TopAlertViewModel(name: "파채", changedStatus: .shortTermUnEaten))
    }
}
