//
//  MainView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct MainView: View {
//    @State var selectedTopTabBar: topTabBar = .basic
//    @State var text: String = ""
//    @State var isSearching = false
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @State var appState = AppState()

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            Spacer()
                .frame(height: 32)
            
            switch mainViewModel.searchingStatus {
            case .notSearching:
                    HStack(alignment: .top) {
                        Button {
                            Analyzer.sendGA(MainViewEvents.basicTerm)
                            mainViewModel.changeSelectedTopTabBar(to: topTabBar.basic)
                        } label: {
                            Text("일반 보관")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundColor(mainViewModel.selectedTopTabBar == topTabBar.basic ? Color("PrimaryGB") : Color("Gray200"))
                        }
                        
                        Spacer()
                            .frame(width: 15)
                        
                        Button{
                            Analyzer.sendGA(MainViewEvents.longTerm)
                            mainViewModel.changeSelectedTopTabBar(to: .longterm)
                        } label: {
                            Text("장기 보관")
                                .font(.pretendard(.bold, size: 28))
                                .foregroundColor(mainViewModel.selectedTopTabBar == .longterm ? Color("PrimaryGB") : Color("Gray200"))
                        }
                    }
                    .padding(.horizontal, 20)
                    
            default:
                Text("검색")
                    .font(.pretendard(.bold, size: 28))
                    .foregroundColor(Color("PrimaryGB"))
                    .padding(.horizontal, 20)
            }
            
            Spacer()
                .frame(height: 20)
            
            SearchBar(mainViewModel: mainViewModel)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        mainViewModel.isFocused = true
                    }
                }
                .onChange(of: mainViewModel.text) { _ in
                    withAnimation(.easeIn(duration: 0.2)) {
                        coreDataViewModel.searchText = mainViewModel.text
                    }
                }
            
            switch mainViewModel.searchingStatus {
            case .notSearching:
                    switch mainViewModel.selectedTopTabBar {
                case .basic:
                    BasicList(appState: appState)
                case .longterm:
                        LongTermList(coreDataViewModel: coreDataViewModel, appState: appState)
                }
            default:
                Group {
                    SearchView(appState: appState, coreDataViewModel: coreDataViewModel)
                        .onTapGesture {
                            withAnimation (.easeInOut(duration: 0.2)){
                                if mainViewModel.text.isEmpty {
                                    mainViewModel.isFocused = false
                                }
                                endTextEditing()
                            }
                        }
                    Spacer()
                }
        }
        }
        .onAppear {
            Analyzer.sendGA(MainViewEvents.appear)
        }
    }
}

struct SearchBar: View {
    @ObservedObject var mainViewModel: MainViewModel
    @State private var isShowCancelButton = false
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(height: 44)
                    .foregroundColor(Color("Gray50"))
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("Gray200"))
                    
                    ZStack(alignment: .leading) {
                        if mainViewModel.text.isEmpty {
                            Text("식재료 검색")
                                .foregroundColor(Color("Gray200"))
                        }
                        HStack {
                            TextField("", text: $mainViewModel.text)
                                .onChange(of: mainViewModel.isFocused) { _ in
                                    switch mainViewModel.searchingStatus {
                                    case .searching:
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                isShowCancelButton = true
                                            }
                                    default:
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                isShowCancelButton = false
                                            }
                                    }
                                }
                            
                            if (mainViewModel.searchingStatus == .searching) || (mainViewModel.searchingStatus == .filled) {
                                Button(action: {
                                    mainViewModel.text = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color("Gray200"))
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            
            if mainViewModel.searchingStatus != .notSearching {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        mainViewModel.isFocused = false
                        mainViewModel.text = ""
                        endTextEditing()
                    }
                }, label: {
                    Text("취소")
                        .padding(.leading, 10)
                })
            }
        }
    }
}


struct SearchView: View {
    @State var appState: AppState
    @ObservedObject var coreDataViewModel: CoreDataViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(coreDataViewModel.searchList) { item in
                    listCell(item: item, appState: appState)

                    Divider()
                        .overlay(Color("Gray100"))
                        .opacity(item == coreDataViewModel.searchList.last ? 0 : 1)
                        .padding(.leading, 20)
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}


struct MainView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
  static var previews: some View {
    MainView()
          .environmentObject(coreDataViewModel)
  }
}
