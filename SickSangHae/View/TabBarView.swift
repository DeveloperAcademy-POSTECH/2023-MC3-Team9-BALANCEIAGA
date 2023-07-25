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
            VStack(spacing: 0) {
                selectedTab.view

                CustomTabView(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct ScanButton: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // Top left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) // Top right
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false) // Top right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom right
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom left
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius)) // Back to start
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false) // Top left corner
        return path
    }
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case .mainView:
                Button {
                    // 카메라 기능을 넣어요
                } label: {
                    ZStack {
                        ScanButton(cornerRadius: 15)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")]), startPoint: .leading, endPoint: .trailing))
                                    .frame(width: screenWidth, height: 55)

                        HStack {
                            Image(systemName: "camera.viewfinder")
                            Text("영수증 스캔하기")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                    }
                }
            default: EmptyView()

            }
            
            Spacer()
                .frame(height: 8)

            HStack {
                TabItem(selectedTabType: .mainView, imageName: selectedTab == .mainView ? "RefActive" : "RefDisActive", title: "냉장고")
                
                Spacer()

                TabItem(selectedTabType: .historyView, imageName: selectedTab == .historyView ? "HistoryActive" : "HistoryDisActive", title: "식기록")
                
                Spacer()

                TabItem(selectedTabType: .chartView, imageName: selectedTab == .chartView ? "ChartActive" : "ChartDisActive", title: "식통계")
                
                Spacer()
                
                TabItem(selectedTabType: .settingView, imageName: selectedTab == .settingView ? "SettingActive" : "SettingDisActive", title: "설정")

            }
            .frame(minWidth: 300, maxWidth: 360)
            .padding(.horizontal, 24)
            
            Spacer()
                .frame(height: 4)
        }
        .frame(width: screenWidth)
    }

    func TabItem(selectedTabType: Tab, imageName: String, title: String) -> some View{
        Rectangle()
            .frame(width: 52, height: 52)
            .foregroundColor(.clear)
            .overlay(
                Button {
                    selectedTab = selectedTabType
                } label: {
                    VStack(spacing: 0) {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                        
                        Spacer()
                            .frame(height: 4)
                        
                        Text(title)
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundColor(selectedTab == selectedTabType ? Color("PrimaryGB") : Color("Gray200"))
                }
            )
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

