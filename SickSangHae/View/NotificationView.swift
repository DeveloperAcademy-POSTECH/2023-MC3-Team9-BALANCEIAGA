//
//  NotificationView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var viewModel: NotificationViewModel
    
    var body: some View {
        switch viewModel.currentCase {
        case .hurryEat:
            NotificationBaseView(title: "빨리 먹어야 해요", periodUint: ["1일","2일","3일"], explain: "'빨리 먹어야 해요' 식료품의 구매일이 \(viewModel.day)일 지났을 경우 알림을 띄웁니다." , viewModel: viewModel, selectedOption: $viewModel.selectedOption)
        case .basic:
            NotificationBaseView(title: "기본", periodUint: ["1주","2주","3주"], explain: "'기본' 식료품의 구매일이 \(viewModel.day)주 지났을 경우 알림을 띄웁니다." , viewModel: viewModel, selectedOption: $viewModel.selectedOption)
        case .longTerm:
            NotificationBaseView(title: "장기보관", periodUint: ["1달","2달","3달"], explain: "'장기보관' 식료품의 구매일이 \(viewModel.day)달 지났을 경우 알림을 띄웁니다." , viewModel: viewModel, selectedOption: $viewModel.selectedOption)
        }
    }
}

struct NotificationBaseView: View {
    var title: String
    var periodUint: [String]
    var explain: String
    @ObservedObject var viewModel: NotificationViewModel
    @Binding var selectedOption: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 10.adjusted)
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 19)
                        .foregroundColor(.gray900)
                }
                Spacer()
                
                Text(title)
                    .font(.pretendard(.bold, size: 17))
                Spacer()
            }
            .padding(.horizontal, 20.adjusted)
            Spacer().frame(height: 36.adjusted)
            radioButtonView(index: 1, selectedIndex: $selectedOption, periodUint: periodUint[0])
            radioButtonView(index: 2, selectedIndex: $selectedOption, periodUint: periodUint[1])
            radioButtonView(index: 3, selectedIndex: $selectedOption, periodUint: periodUint[2])
            Spacer().frame(height: 12.adjusted)
            Text(explain)
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(.gray600)
                .padding(.leading, 24.adjusted)
            Spacer()
            
        }
        .onChange(of: selectedOption) { newValue in
            viewModel.updateDay(for: newValue)
        }
        
    }
}

struct radioButtonView: View {
    var index: Int
    @Binding var selectedIndex: Int
    var periodUint: String
    
    var body: some View {
        Button {
            selectedIndex = index
        } label: {
            ZStack(alignment: .bottom) {
                HStack(spacing: 16.adjusted) {
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: selectedIndex == index ? .selectedGradient: .notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: selectedIndex == index ? .selectedGradient : .clearGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    
                    Text(periodUint)
                        .font(.pretendard(.semiBold, size: 17))
                        .foregroundColor(.gray900)
                    Spacer()
                }
                .padding(.horizontal, 24.adjusted)
                .padding(.vertical, 24)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray50)
            }
        }
    }
}



struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(viewModel: NotificationViewModel(currentCase: .longTerm))
    }
}
