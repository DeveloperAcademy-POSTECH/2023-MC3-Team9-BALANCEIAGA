//
//  HistoryView.swift
//  SickSangHae
//
//  Created by kimsangwoo on 2023/07/17.
//

import SwiftUI

struct HistoryView: View {
    
    
    
    let array = [
        "당근", "계란30구", "과자", "팝콘", "요거트", "당당치킨", "친환경양파", "깐마늘",
        "맛있는우유", "월드콘", "돼지고기 목살", "깻잎", "딸기잼", "머스타드 소스", "된장",
        "고추장", "어묵", "아무거나"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(array, id:\.self) { itemText in
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.gray)
                        Text(itemText)
                            .frame(
                                width: screenWidth * 0.67,
                                height: 60,
                                alignment: .leading)
                            .font(.system(size: 17, weight: .bold))
                            .padding(.leading, 8)
                        Menu {
                            Button(action: {
                                //아이템 상태 복구 로직
                            }, label: {
                                Text("복구하기")
                                Image(systemName: "arrow.counterclockwise")
                            })
                            Button(action: {
                                //아이템 상태 변경 로직
                            }, label: {
                                Text("상했어요")
                                Image(systemName: "arrow.triangle.2.circlepath")
                            })
                            Divider()
                            Button(role: .destructive, action: {
                                
                            }, label: {
                                Text("삭제하기")
                                Image(systemName: "trash")
                            })
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .frame(width: 22, height: 5)
                                .foregroundColor(.gray)
                                .padding(.trailing, screenWidth * 0.03)
                        }
                    } //HStack닫기
                } //ForEach닫기
            } //List닫기
            .listStyle(.plain)
            .navigationBarItems(leading: leadingText)
            .toolbarBackground(
                .white,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        } //NavigationStack닫기
    } //body닫기
    
    var leadingText: some View {
        Text("보관함")
            .font(.system(size: 28, weight: .bold))
    }
}

//struct TopSegmentedTabBar: View {
//
//    @State private var isMovingSegmentedTab : Bool = true
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            Rectangle()
//                .foregroundColor(.white)
//                .frame(height: screenHeight * 0.21)
//
//            VStack(spacing: 0) {
//                HStack {
//                    VStack {
//                        Button(action: {
//                            isMovingSegmentedTab = true
//                        }, label: {
//                            Text("먹었어요😋")
//                                .font(.system(size: 20, weight: .bold))
//                                .foregroundColor(.black)
//                        })
//                        Rectangle()
//                            .foregroundColor(isMovingSegmentedTab ? .blue : .white)
//                            .frame(width: screenWidth * 0.36, height: 3)
//                    }
//                    Spacer()
//                        .frame(width: screenWidth * 0.12)
//                    VStack {
//                        Button(action: {
//                            isMovingSegmentedTab = false
//                        }, label: {
//                            Text("상했어요")
//                                .font(.system(size: 20, weight: .bold))
//                                .foregroundColor(.black)
//                        })
//                        Rectangle()
//                            .foregroundColor(isMovingSegmentedTab ? .white : .blue)
//                            .frame(width: screenWidth * 0.36, height: 3)
//                    }
//                } //HStack닫기
//                Divider()
//            } //VStack닫기
//
//            Text("보관함")
//                .font(.system(size: 28, weight: .bold))
//                .frame(width: screenWidth, alignment: .leading)
//                .padding(.leading, screenWidth * 0.1)
//                .padding(.bottom, screenHeight * 0.08)
//        } //ZStack닫기
//    } //body닫기
//} //struct닫기

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
