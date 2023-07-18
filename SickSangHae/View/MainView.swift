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

    @State var selectedTopTab: topTabBar = .basic

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
                    .frame(width: CGFloat(7.5).adjusted)

                Button{
                    selectedTopTab = .longterm
                } label: {
                    Text("장기 보관")
                        .font(.system(size: 28.adjusted).weight(.bold))
                        .foregroundColor(selectedTopTab == .longterm ? Color("PrimaryGB") : Color("Gray200"))
                }
            }
            .padding()

            TabBarView()
        }

    }


}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
