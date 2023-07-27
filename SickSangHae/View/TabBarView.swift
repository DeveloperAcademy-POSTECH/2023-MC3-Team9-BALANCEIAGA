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

class AppState: ObservableObject {
    @Published var moveToRootView: Bool = false
}

struct TabBarView: View {
    @State var selectedTab: Tab = .mainView
    let appState: AppState
    @StateObject var coreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                selectedTab.view
                    .environmentObject(coreDataViewModel)

                CustomTabView(selectedTab: $selectedTab, appState: appState)
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
    @State var isActive = false
    @EnvironmentObject private var cameraViewModelShared: CameraViewModel

    let appState: AppState
    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case .mainView:
                Button {
                    isActive = true
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
                .navigationDestination(isPresented: $isActive, destination: {
                    CameraView(appState: appState)
                })
                .onReceive(self.appState.$moveToRootView) { moveToDashboard in
                    if moveToDashboard {
                        self.isActive = false
                        self.appState.moveToRootView = false
                        cameraViewModelShared.isCapturedShowPreview = false
                        cameraViewModelShared.isSelectedShowPreview = false
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



