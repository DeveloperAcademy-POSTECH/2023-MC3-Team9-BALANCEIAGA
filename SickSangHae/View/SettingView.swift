//
//  SettingVIew.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct SettingView: View {
    @State private var isModalOpen = false
    @StateObject private var viewModel = SettingViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 25)
            Text("설정")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primaryGB)
                .padding(.horizontal, 20)
            Spacer().frame(height: 14)
            VStack{
                ForEach(viewModel.settingListItems, id: \.title) { item in
                    listContent(item: item)
                    if viewModel.isShowListSection(for: item) {
                         listSection
                     }
                }
            }
            Spacer()
        }

    }
    
    private func listContent(item: SettingListItem) -> some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer().frame(height: 24)
                HStack {
                    VStack(alignment:.leading, spacing: 4) {
                        Text(item.title)
                            .font(.pretendard(.medium, size: 17))
                            .foregroundColor(.gray900)
                        if item.isSubTitle {
                            Text(item.subTitle ?? "")
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.gray400)
                        }
                    }
                    Spacer()
                    if item.isToggle {
                        Toggle("", isOn: $viewModel.isOnToggle)
                            .toggleStyle(.switch)
                            .tint(Color.primaryGB)
                            .frame(width: 50, height: 30)
                    } else {
                        listButton(text: item.buttonTitle)
                    }
                }
                Spacer().frame(height: 24)
                
            }
            .padding(.horizontal, 20)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray50)
        }
    }
    
    private func listButton(text: String) -> some View{
            Button(action: {
                self.isModalOpen = true
            }, label: {
                HStack(spacing: 14.adjusted) {
                    Text(text)
                        .font(.pretendard(.medium, size: 17))
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 6, height: 11)
                }
            })
            .foregroundColor(.primaryGB)
        }
    
    private var listSection: some View {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: screenWidth, height: 12)
                .background(Color.gray100)
    }
    
}

struct SettingVIew_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
