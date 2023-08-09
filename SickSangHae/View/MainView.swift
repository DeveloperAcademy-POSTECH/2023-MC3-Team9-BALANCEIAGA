//
//  MainView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

enum topTabBar{
    case basic
    case longterm
}

struct MainView: View {
    @State var selectedTopTabBar: topTabBar = .basic
    @State var text: String = ""
    @State var isSearching = false
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @State var appState = AppState()

    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            Spacer()
                .frame(height: 32)
            
            if text.isEmpty && isSearching == false {
                HStack(alignment: .top) {
                    Button{
                        selectedTopTabBar = .basic
                    } label: {
                        Text("일반 보관")
                            .font(.pretendard(.bold, size: 28))
                            .foregroundColor(selectedTopTabBar == .basic ? Color("PrimaryGB") : Color("Gray200"))
                    }
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Button{
                        selectedTopTabBar = .longterm
                    } label: {
                        Text("장기 보관")
                            .font(.pretendard(.bold, size: 28))
                            .foregroundColor(selectedTopTabBar == .longterm ? Color("PrimaryGB") : Color("Gray200"))
                    }
                }
                .padding(.horizontal, 20)
                
                
            } else {
                Text("검색")
                    .font(.pretendard(.bold, size: 28))
                    .foregroundColor(Color("PrimaryGB"))
                    .padding(.horizontal, 20)
            }
            
            Spacer()
                .frame(height: 20)
            
            SearchBar(text: $text, isInputActive: $isSearching)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearching = true
                    }
                }
                .onChange(of: text) { _ in
                    withAnimation(.easeIn(duration: 0.2)) {
                        coreDataViewModel.searchText = text
                    }
                }
            
            if text.isEmpty && isSearching == false {
                switch selectedTopTabBar {
                case .basic:
                    BasicList(appState: appState)
                case .longterm:
                    LongTermList(coreDataViewModel: coreDataViewModel, listContentViewModel: ListContentViewModel(status: .longTermUnEaten, itemList: coreDataViewModel.longTermUnEatenList), appState: appState)
                }
            } else {
                SearchView(appState: appState, coreDataViewModel: coreDataViewModel)
                    .onTapGesture {
                        withAnimation (.easeInOut(duration: 0.2)){
                            if text.isEmpty {
                                isSearching = false
                            }
                            endTextEditing()
                        }
                    }
                Spacer()
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
    @FocusState var isInputActive: Bool

    var body: some View {
        HStack {
            Spacer()
                .frame(width: 12)
            
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("Gray200"))
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("식재료 검색")
                        .foregroundColor(Color("Gray200"))
                } else {
                    EmptyView()
                }
                TextField("", text: $text)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("완료") {
                                isInputActive = false
                            }
                        }
                    }
                
                if text.isEmpty || !isInputActive {
                    EmptyView()
                } else {
                    Button(action: {
                        self.text = ""
                    }) {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("Gray200"))
                        }
                    }
                }
            }
            .padding(.leading, 4)
            .padding(.trailing, 12)
        }
        .frame(height: 42)
        .background(Color("Gray50"))
        .cornerRadius(10)
    }
}


struct MainView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
  static var previews: some View {
    MainView()
          .environmentObject(coreDataViewModel)
  }
}

