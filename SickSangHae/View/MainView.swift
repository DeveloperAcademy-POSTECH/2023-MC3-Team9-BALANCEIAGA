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
// Dummy Data
let data = ["Apple", "Banana", "Orange", "Pineapple", "Grapes", "Watermelon", "Mango", "Papaya", "Cherry"]

struct MainView: View {

    @State var selectedTopTab: topTabBar = .basic
    @State private var searchText = ""
    @State private var isSearching = false
    @State var text: String = ""

    var body: some View {

        VStack(alignment: .leading){
            Spacer()
                .frame(height: 32.adjusted)
            HStack(alignment: .top){
                Spacer()
                    .frame(width: 20.adjusted)

                Button{
                    selectedTopTab = .basic
                } label: {
                    Text("기본")
                        .font(.system(size: 28.adjusted).weight(.bold))
                        .foregroundColor(selectedTopTab == .basic ? Color("PrimaryGB") : Color("Gray200"))
                }

                Spacer()
                    .frame(width: CGFloat(15).adjusted)

                Button{
                    selectedTopTab = .longterm
                } label: {
                    Text("장기 보관")
                        .font(.system(size: 28.adjusted).weight(.bold))
                        .foregroundColor(selectedTopTab == .longterm ? Color("PrimaryGB") : Color("Gray200"))
                }
            }
            .padding()

            Spacer()
                .frame(height: 30.adjusted)

            SearchBar(text: $text)

            TabBarView()
        }

    }

}

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false
    @FocusState var isInputActive: Bool

    var body: some View {
//        HStack {
//
//            TextField("식료품 검색 ...", text: $text)
//                .padding(7)
//                .padding(.horizontal, 25)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal, 10)
//                .onTapGesture {
//                    self.isEditing = true
//                }
//
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.text = ""
//
//                }) {
//                    Text("Cancel")
//                }
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
//        }

        TextField("Enter your name", text: $text)
            .textFieldStyle(.roundedBorder)
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()

                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
    }
}


struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
