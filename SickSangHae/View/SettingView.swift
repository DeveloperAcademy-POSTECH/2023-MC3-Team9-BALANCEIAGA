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
    @ObservedObject private var notiManager = NotifiactionManager()
    @State private var buttonClickCount = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 25)
            Text("설정")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primaryGB)
                .padding(.horizontal, 20)
            Spacer().frame(height: 42)
            
            HStack {
                Text(notiManager.isNotiOn ? "앱 푸시 알림을 허용했어요" : "앱 푸시 알림 허용하러 가기")
                    .font(.pretendard(.medium, size: 17))
                    .foregroundColor(.gray900)
                Spacer()
                Button {
                    if buttonClickCount == 0 {
                        notiManager.isNotiOn = true
                    } else {
                        notiManager.openSettings()
                    }
                    buttonClickCount += 1
                    Analyzer.sendGA(SettingViewEvents.toSystemSetting)
                } label: {
                    HStack(spacing: 14.adjusted) {
                        Text("설정")
                            .font(.pretendard(.medium, size: 17))
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 6, height: 11)
                    }
                }
                .foregroundColor(.primaryGB)
                
            }
            .padding(.horizontal, 20)
            Spacer().frame(height: 24)
            
            listSection
            VStack{
                ForEach(viewModel.settingListItems.indices, id: \.self) { index in
                    listContent(item: viewModel.settingListItems[index], index: index)
                    if viewModel.isShowListSection(for: viewModel.settingListItems[index]) {
                        listSection
                    }
                }
            }
            .disabled(notiManager.isNotiOn ? false : true)
            Spacer()
        }
        
        //앱의 foreground 상태 판단
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            notiManager.updateIsNotiOnStatus()
        }
    }
    
    private func listContent(item: SettingListItem, index: Int) -> some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer().frame(height: 24)
                HStack {
                    VStack(alignment:.leading, spacing: 4) {
                        Text(item.title)
                            .font(.pretendard(.medium, size: 17))
                            .foregroundColor(notiManager.isNotiOn ? .gray900 : .gray200)
                        if item.isSubTitle {
                            Text(item.subTitle ?? "")
                                .font(.pretendard(.regular, size: 14))
                                .foregroundColor(notiManager.isNotiOn ? .gray400 : .gray200)
                        }
                    }
                    Spacer()
                    if item.isToggle {
                        Toggle("", isOn: $viewModel.settingListItems[index].isOnToggle)
                            .toggleStyle(.switch)
                            .tint(notiManager.isNotiOn ? Color.primaryGB : Color.gray200)
                            .frame(width: 50, height: 30)
                            .onChange(of: viewModel.settingListItems[index].isToggle) { _ in // MARK: settingview의 toggle들만 GA 확인
                                switch index {
                                case 0: //
                                    Analyzer.sendGA(SettingViewEvents.expireNotificationToggle)
                                case 4:
                                    Analyzer.sendGA(SettingViewEvents.cleanNotificationToggle)
                                case 5:
                                    Analyzer.sendGA(SettingViewEvents.chartNotificationToggle)
                                default:
                                    break
                                }
                            }
                    } else {
                        listButton(text: item.buttonTitle, for: item)
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
    
    private func listButton(text: String, for item: SettingListItem) -> some View{
        NavigationLink {
            NotificationView(viewModel: NotificationViewModel(currentCase: viewModel.navigationNoti(for: item)))
                .navigationBarBackButtonHidden(true)
        } label: {
            HStack(spacing: 14.adjusted) {
                Text(text)
                    .font(.pretendard(.medium, size: 17))
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 6, height: 11)
            }
            .foregroundColor(notiManager.isNotiOn ? .primaryGB : .gray200)
        }
        
    }
    
    private var listSection: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: screenWidth, height: 12)
            .background(Color.gray100)
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
