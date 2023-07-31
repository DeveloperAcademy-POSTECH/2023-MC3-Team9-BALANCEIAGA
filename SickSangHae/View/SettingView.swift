//
//  SettingVIew.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct SettingView: View {
    @State private var isModalOpen = false
    @State private var isOnToggle = false
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 25)
            Text("설정")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primaryGB)
                .padding(.horizontal, 20)
            Spacer().frame(height: 14)
            VStack{
                listContent(title: "앱 푸시 알림", isSubTitle: false, subTitle: nil, isToggle: false, buttonTitle: "설정")
                listSection
                listContent(title: "식료품 경과일 알림", isSubTitle: true, subTitle: "설정한 기준일이 지난 경우 알려드려요", isToggle: true, buttonTitle: "")
                
                listContent(title: "빨리 먹어야 해요", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "2일")
                
                listContent(title: "기본", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "1주")
                listContent(title: "장기보관", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "1달")
                listSection
                listContent(title: "식재료 정리 알림", isSubTitle: true , subTitle: "주기적인 냉장고 정리를 위해 알려드려요", isToggle: true, buttonTitle: "")
                listContent(title: "식통계 알림", isSubTitle: true, subTitle: "매월 1일 통계를 확인하도록 알려드려요.", isToggle: true, buttonTitle: "")
            }
            Spacer()
        }

    }
    
    private func listContent(title: String, isSubTitle: Bool, subTitle: String?, isToggle: Bool, buttonTitle: String) -> some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer().frame(height: 24)
                HStack {
                    VStack(alignment:.leading, spacing: 4) {
                        Text(title)
                            .font(.pretendard(.medium, size: 17))
                            .foregroundColor(.gray900)
                        if isSubTitle {
                            Text(subTitle ?? "")
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(.gray400)
                        }
                    }
                    Spacer()
                    if isToggle {
                        Toggle("", isOn: $isOnToggle)
                            .toggleStyle(.switch)
                            .tint(Color.primaryGB)
                            .frame(width: 50, height: 30)
                    } else {
                        listButton(text: buttonTitle)
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
