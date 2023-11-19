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
            case .settingView: SettingView()
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

                CustomTabView(selectedTab: $selectedTab, appState: appState)
            }
            .ignoresSafeArea(.keyboard)
        }
        .environmentObject(coreDataViewModel)
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
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    let appState: AppState
    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .mainView:
                Button {
                    isActive = true
                } label: {
                    ZStack {
                      ScanButton(cornerRadius: 16)
                            .foregroundColor(.primaryGB)
//                        .fill(LinearGradient(gradient: Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: screenWidth, height: 61)
                      
                      HStack {
                        Image(systemName: "camera.viewfinder")
                        Text("영수증 스캔하기")
                              .font(.pretendard(.semiBold, size: 17))
                      }
                      .foregroundColor(.white)
                      .padding(.bottom, 6)
                    }
                    .padding(.bottom, 64)
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
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(maxHeight: 70)
                
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
            }
            
            
            Spacer()
                .frame(height: 4)
        }
        .frame(width: screenWidth)
        .onChange(of: selectedTab) { _ in
            coreDataViewModel.searchText = ""
        }
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
                            .font(.pretendard(.medium, size: 11))
                    }
                    .foregroundColor(selectedTab == selectedTabType ? Color("PrimaryGB") : Color("Gray200"))
                }
            )
    }
}



struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(appState: AppState())
    }
}
