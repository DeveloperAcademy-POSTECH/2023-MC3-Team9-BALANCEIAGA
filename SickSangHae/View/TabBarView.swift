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
    @State var selectedTab: Tab = .MainView

    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                switch selectedTab {
                case .MainView:
                    MainView()
                case .HistoryView:
                    HistoryView()
                case .ChartView:
                    ChartView()
                case .SettingView:
                    SettingVIew()
                }
                
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
            if selectedTab == .MainView{
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
            }
            
            Spacer()
                .frame(height: 14)
            
            HStack {
                Rectangle()
                    .frame(width: 48, height: 44)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .MainView
                        } label: {
                            VStack{
                                Image(systemName: "refrigerator.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24)
                                Text("냉장고")
                                    .font(.system(size: 11, weight: .medium))
                            }
                            .foregroundColor(selectedTab == .MainView ? Color("PrimaryGB") : Color("Gray200"))
                        }
                    )
                
                Spacer()
                
                Rectangle()
                    .frame(width: 48, height: 44)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .HistoryView
                        } label: {
                            VStack{
                                Image(systemName: "archivebox.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24)
                                Text("식기록")
                                    .font(.system(size: 11, weight: .medium))
                            }
                            .foregroundColor(selectedTab == .HistoryView ? Color("PrimaryGB") : Color("Gray200"))
                        }
                    )
                
                Spacer()
                
                Rectangle()
                    .frame(width: 48, height: 44)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .ChartView
                        } label: {
                            VStack{
                                Image(systemName: "chart.pie.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24)
                                Text("식통계")
                                    .font(.system(size: 11, weight: .medium))
                            }
                            .foregroundColor(selectedTab == .ChartView ? Color("PrimaryGB") : Color("Gray200"))
                        }
                    )
                
                Spacer()
                
                Rectangle()
                    .frame(width: 48, height: 44)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .SettingView
                        } label: {
                            VStack{
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24)
                                Text("설정")
                                    .font(.system(size: 11, weight: .medium))
                            }
                            .foregroundColor(selectedTab == .SettingView ? Color("PrimaryGB") : Color("Gray200"))
                        }
                    )
            }
            .frame(width: screenWidth * 0.85)
            
            Spacer()
                .frame(height: 14)
        }
        .frame(width: screenWidth)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

