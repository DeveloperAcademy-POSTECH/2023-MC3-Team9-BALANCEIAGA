//
//  HistoryView.swift
//  SickSangHae
//
//  Created by kimsangwoo on 2023/07/17.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject var coreDataViewModel = CoreDataViewModel()
    
    @State var isMovingSegmentedTab : Bool = true
    
    let array = [
        "당근", "계란30구", "과자", "팝콘", "요거트"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                //히스토리 뷰 본체
                VStack(spacing: 0) {
                    
                    //상단 탭 영역
                    topHeader
                    
                    //아이템 리스트 뷰
                    List {
                        
                        //아이템 리스트 헤더 날짜
                        listHeaderDate
                        
                        //아이템 리스트
                        itemList
                    }
                    .listStyle(.plain)
                }
                .ignoresSafeArea()
            } //ZStack닫기
        } //NavigationStack닫기
    } //body닫기
    
    var topHeader: some View {
        //상단 탭 뷰
        ZStack(alignment: .top) {
            ZStack(alignment: .bottom) {
                //백그라운드
                headerBackground
                
                //버튼 및 타이틀
                VStack(spacing: 0) {
                    
                    //타이틀
                    titleText
                    
                    //Test버튼
                    Button(action: {
                        coreDataViewModel
                        print(">>>AddModel")
                    }, label: {
                        Text("추가")
                    })
                    
                    //버튼
                    segmentedTabButton
                    
                    //하단구분선
                    Divider()
                } //VStack닫기
                .frame(
                    width: screenWidth)
            }
        } //ZStack닫기
    }
    
    var headerBackground: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(
                width: screenWidth,
                height: screenHeight * 0.2)
            .ignoresSafeArea()
    }
    
    var titleText: some View {
        Text("보관함")
            .font(.system(size: 28, weight: .bold))
            .frame(
                width: screenWidth * 0.9,
                height: screenHeight * 0.07,
                alignment: .topLeading)
    }
    
    var segmentedTabButton: some View {
        HStack {
            VStack {
                Button(action: {
                    isMovingSegmentedTab = true
                }, label: {
                    Text("먹었어요😋")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                })
                Rectangle()
                    .foregroundColor(isMovingSegmentedTab ? .black : .clear)
                    .frame(width: screenWidth * 0.36, height: 3.adjusted)
            }
            Spacer()
            VStack {
                Button(action: {
                    isMovingSegmentedTab = false
                }, label: {
                    Text("상했어요🤢")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                })
                Rectangle()
                    .foregroundColor(isMovingSegmentedTab ? .clear : .black)
                    .frame(width: screenWidth * 0.36, height: 3.adjusted)
            }
        } //HStack닫기
        .frame(
            width: screenWidth * 0.8)
    }
    
    var listHeaderDate: some View {
        HStack {
            Text("2023년 7월 21일")
                .font(.system(size: 20, weight: .bold))
            
            Spacer()
            
            Text("88일 남음")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
        }
        .frame(width: screenWidth * 0.9)
        .padding(.top, 12.adjusted)
    }
    
    var itemList: some View {
        ForEach(array, id:\.self) { item in
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.gray)
                    Text(item)
                        .frame(
                            height: 60,
                            alignment: .leading)
                        .font(.system(size: 17, weight: .bold))
                        .padding(.leading, 8)
                    Spacer()
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
                    }
                } //HStack닫기
                .frame(width: screenWidth * 0.9)
                
                Divider()
                    .frame(width: screenWidth * 0.9, alignment: .trailing)
            }
            .listRowSeparator(.hidden)
            .frame(width: screenWidth)
        } //ForEach닫기
        .padding(.vertical, -7.adjusted)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
