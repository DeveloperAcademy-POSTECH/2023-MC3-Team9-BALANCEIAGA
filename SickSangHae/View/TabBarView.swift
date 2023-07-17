//
//  TabBarView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct TabBarView: View {
    // views에 다른 뷰를 넣으면 돼요. 현재는 알아보기 쉽게하기 위해 color를 넣어 두었어요.
    let views: [Color] = [ .yellow, .blue, .green, .indigo]
    let icons = ["bag.fill", "chart.bar", "newspaper.fill", "circle.inset.filled"]
    let tabbarItems = [ "나의 냉장고", "통계", "보관함", "설정" ]

        var body: some View {
            TabView {
                ForEach(views.indices, id: \.self) { index in
                    views[index]
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tag(index)
                        .tabItem {
                            Image(systemName: icons[index])
                            Text(tabbarItems[index])
                        }
                }
            }
        }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
