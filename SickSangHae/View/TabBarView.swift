//
//  TabBarView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

enum Tab {
    case MainView
    case ChartView
    case HistoryView
    case SettingView
}

struct TabBarView: View {
    //Custom TabView
    @State var selectedTab: Tab = .MainView
    var body: some View {
        VStack {
            Spacer()
            switch selectedTab {
            case .MainView:
                Text("The MainView Tab")
            case .ChartView:
                Text("The ChartView Tab")
            case .HistoryView:
                Text("The HistoryView Tab")
            case .SettingView:
                Text("The SettingView Tab")
            }
            Spacer()

            CustomTabView(selectedTab: $selectedTab)
        }
    }

}

struct CustomTabView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)

            Button{
                // 카메라 기능을 넣어요
            } label: {
                ZStack{
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: screenWidth, height: 60.adjusted)
                        .foregroundColor(.blueGrayColor)
                        .padding(.bottom, 12.adjusted)
                        .cornerRadius(12.adjusted)
                        .padding(.bottom, -12.adjusted)

                    HStack{
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 20.adjusted))
                        Text("영수증 스캔하기")
                            .font(.system(size: 17.adjusted))
                    }
                    .foregroundColor(.white)

                }
            }
            .padding(.bottom, 150.adjusted)

            HStack {
                Spacer()
                    .frame(width: 10.adjusted)
                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .MainView
                        } label: {
                            VStack{
                                Image(systemName: selectedTab == .MainView ? "bag.fill" : "bag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                    .foregroundColor(selectedTab == .MainView ? .mint : .gray)
                                Text("나의 냉장고")
                                    .foregroundColor(selectedTab == .MainView ? .mint : .gray)
                                    .font(.system(size: 14.adjusted))
                            }
                        }
                    )

                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .ChartView
                } label: {
                    VStack{
                        Image(systemName: "chart.bar.xaxis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .ChartView ? .mint : .gray)
                        Text("통계")
                            .foregroundColor(selectedTab == .ChartView ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                        }
                    }
                )
                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .HistoryView
                } label: {
                    VStack{
                        Image(systemName: selectedTab == .HistoryView ? "newspaper.fill" : "newspaper")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .HistoryView ? .mint : .gray)
                        Text("보관함")
                            .foregroundColor(selectedTab == .HistoryView ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                        }
                    }
                )
                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .SettingView
                } label: {
                    VStack{
                        Image(systemName: selectedTab == .SettingView ? "circle.fill" : "circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .SettingView ? .mint : .gray)
                        Text("설정")
                            .foregroundColor(selectedTab == .SettingView ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                        }
                    }
                )
                Spacer()
                    .frame(width: 10.adjusted)
            }

        }
        .frame(height: 90.adjusted)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
