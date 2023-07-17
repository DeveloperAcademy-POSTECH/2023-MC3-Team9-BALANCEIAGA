//
//  HistoryView.swift
//  SickSangHae
//
//  Created by kimsangwoo on 2023/07/17.
//

import SwiftUI

struct HistoryView: View {
    
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
//    }
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
        appearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    
    let array = [
        "당근", "계란30구", "과자", "팝콘", "요거트", "당당치킨", "친환경양파", "깐마늘",
        "맛있는우유", "월드콘", "돼지고기 목살", "깻잎", "딸기잼", "머스타드 소스", "된장",
        "고추장", "어묵", "아무거나"
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section(header: StickyHeaderBar()) {
                        VStack {
                            ForEach(array, id:\.self) { itemText in
                                HStack {
                                    RoundedRectangle(cornerRadius: 18)
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(.gray)
                                    Text(itemText)
                                        .frame(
                                            width: screenWidth * 0.8,
                                            height: 70,
                                            alignment: .leading)
                                        .font(.system(size: 17, weight: .bold))
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarTitle("보관함")
        }
    }
}

struct StickyHeaderBar: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 70)
                .foregroundColor(.white)
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        //탭 전환 로직
                    }, label: {
                        Text("먹었어요😋")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    })
                    Spacer()
                        .frame(width: screenWidth * 0.18)
                    Button(action: {
                        //탭 전환 로직
                    }, label: {
                        Text("상했어요🤢")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                    })
                }
                
                Divider()
                    .padding(.top, screenHeight * 0.02)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
