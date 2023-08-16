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
    //  @GestureState private var dragOffset = CGSize.zero
    @ObservedObject var viewModel: TopAlertViewModel

    // TODO: TopAlert의 애니메이션 이슈가 해결되면 드래그 기능을 다시 활용

    var body: some View {
        if viewModel.isAlertVisible {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 34)
                    .stroke(strokeColor, lineWidth: 2)
                    .background(Color.alertGreen)
                    .frame(height: 68)
                    .clipShape(RoundedRectangle(cornerRadius: 34))
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(.primaryGB)
                            .frame(width: 40, height: 40)
                    }
                    Text(message)
                        .font(.pretendard(.bold, size: 14))
                        .foregroundColor(.gray800)
                        .padding(.leading, 10)
                }
                .padding(.horizontal, 14)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct TopAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TopAlertView(viewModel: TopAlertViewModel(name: "파채", changedStatus: .shortTermUnEaten))
    }
}
