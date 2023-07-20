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
        NavigationStack{
            VStack {
                switch selectedTab {
                case .MainView:
                    MainView()
                case .ChartView:
                    ChartView()
                case .HistoryView:
                    Text("The HistoryView Tab")
                case .SettingView:
                    SettingVIew()
                }
                
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
                if selectedTab == .MainView{
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
                                selectedTab = .MainView
                            } label: {
                                VStack{
                                    Image(systemName: "refrigerator.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("냉장고")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .MainView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )

                    Spacer()
                        .frame(width: screenWidth * 0.11)
//                        .frame(width: 50.adjusted)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .ChartView
                            } label: {
                                VStack{
                                    Image(systemName: "chart.pie.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("통계")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .ChartView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )
                    Spacer()
                        .frame(width: screenWidth * 0.11)
//                        .frame(width: 50.adjusted)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .HistoryView
                            } label: {
                                VStack{
                                    Image(systemName: "archivebox.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("보관함")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .HistoryView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )

                    Spacer()
                        .frame(width: screenWidth * 0.11)
//                        .frame(width: 50.adjusted)

                    Rectangle()
                        .frame(width: 48.adjusted, height: 49.adjusted)
                        .foregroundColor(.clear)
                        .overlay(
                            Button {
                                selectedTab = .SettingView
                            } label: {
                                VStack{
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjusted)
                                    Text("설정")
                                        .font(.system(size: 11.adjusted))
                                }
                                .foregroundColor(selectedTab == .SettingView ? Color("PrimaryGB") : Color("Gray200"))
                            }
                        )
                }
//                .background(.blue)
                .padding(.bottom, 10.adjusted)
            }
        }
//        .background(.red)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
