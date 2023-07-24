//
//  TabBarView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

enum Tab: CaseIterable {
    case mainView
    case chartView
    case historyView
    case settingView

    @ViewBuilder
        var view: some View {
            switch self {
            case .mainView: MainView()
            case .chartView: ChartView()
            case .historyView: HistoryView()
            case .settingView: SettingVIew()
            }
        }
}

struct TabBarView: View {
    @State var selectedTab: Tab = .mainView

    var body: some View {
        NavigationStack{
            VStack {
                selectedTab.view

                CustomTabView(selectedTab: $selectedTab)
            }
        }
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack{
                if selectedTab == .mainView{
                    Button{
                        // 카메라 기능을 넣어요
                    } label: {
                        ZStack{
                            Rectangle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")]), startPoint: .leading, endPoint: .trailing))
                                .frame(width: screenWidth, height: 55.adjusted)
                                .foregroundColor(.blueGrayColor)
                                .padding(.bottom, 12.adjusted)
                                .cornerRadius(15.adjusted)
                                .padding(.bottom, -12.adjusted)

                            HStack{
                                Image(systemName: "camera.viewfinder")
                                Text("영수증 스캔하기")
                            }
                            .font(.system(size: 17.adjusted).weight(.semibold))
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.bottom, 10.adjusted)
                }

                HStack {
                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .mainView
                            } label: {
                                VStack{
                                    Image(systemName: "refrigerator.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("냉장고")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .mainView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )

                    Spacer()
                        .frame(width: screenWidth * 0.11)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .chartView
                            } label: {
                                VStack{
                                    Image(systemName: "chart.pie.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("통계")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .chartView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )
                    Spacer()
                        .frame(width: screenWidth * 0.11)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .historyView
                            } label: {
                                VStack{
                                    Image(systemName: "archivebox.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("보관함")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .historyView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )

                    Spacer()
                        .frame(width: screenWidth * 0.11)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .settingView
                            } label: {
                                VStack{
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("설정")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .settingView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )
                }
                .padding(.bottom, 10.adjusted)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
