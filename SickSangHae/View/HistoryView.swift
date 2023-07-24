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
    
    let array = ["Apple", "Banana", "Orange", "Pineapple", "Grapes", "Watermelon"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                topHeader
                
                ScrollView {
                    deleteNotiMessage
                    
                    listSection
                    
                    listSection
                    
                } //ScrollView닫기
                .listStyle(.plain)
                
            } //VStack닫기
            
        } //NavigationStack닫기
        
    } //body닫기
    
    
    var topHeader: some View {
        //버튼 및 타이틀
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
                .frame(height: 32)
            
            Text("보관함")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color("PrimaryGB"))
                .padding(.horizontal, 20)
            
            Spacer()
                .frame(height: 20)
            
            segmentedTabButton
                .padding(.horizontal, 20)
            
        } //VStack닫기
        
    } //topHeader닫기
    
    var segmentedTabButton: some View {
        HStack {
            VStack(spacing: 0) {
                Spacer()
                
                Button(action: {
                    isMovingSegmentedTab = true
                }, label: {
                    Text("먹었어요😋")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("Gray900"))
                }) //Button닫기
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 1.5)
                    .foregroundColor(isMovingSegmentedTab ? Color("PrimaryGB") : .clear)
                    .frame(width: screenWidth * 0.4, height: 3)
            } //VStack닫기
            
            Spacer()
            
            VStack(spacing: 0) {
                Spacer()
                
                Button(action: {
                    isMovingSegmentedTab = false
                }, label: {
                    Text("상했어요🤢")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("Gray900"))
                }) //Button닫기
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 1.5)
                    .foregroundColor(isMovingSegmentedTab ? .clear : Color("PrimaryGB"))
                    .frame(width: screenWidth * 0.4, height: 3)
            } //VStack닫기
        } //HStack닫기
        .frame(height: 52)
    } //segmentedTabButton닫기
    
    
    var deleteNotiMessage: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24)
            
            Text("아래의 항목들은 이곳에서 90일 동안 보관됩니다. 각 항목들은 90일이 지나면 영구적으로 삭제됩니다.")
                .font(.system(size: 14))
                .foregroundColor(Color("Gray600"))
            
        } //VStack닫기
        .padding(.horizontal, 18)
        
    } //deleteNotiMessage닫기
    
    
    var listSection: some View {
        VStack(spacing: 0) {
            listTitle
            
            itemList
            
            Spacer()
                .frame(height: 4)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: screenWidth, height: 12)
                .background(Color("Gray100"))
            
        } //VStack닫기
        
    } //listSection닫기
    
    var listTitle: some View {
        HStack {
            Text("2023년 7월 21일")
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20).weight(.semibold))
            
            Spacer()
            
            Text("88일 남음")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("Gray600"))
            
        } //HStack닫기
        .padding([.top, .bottom], 17)
        .padding([.leading, .trailing], 20)
        
    } //listTitle닫기
    
    var itemList: some View {
        ForEach(array, id:\.self) { item in
            VStack {
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color("Gray200"))
                        .frame(width: 36, height: 36)
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Text(item)
                        .font(.system(size: 17).weight(.semibold))
                        .foregroundColor(Color("Gray900"))
                    
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
                            Image(systemName: "trash.fill")
                        })
                    } label: {
                        Rectangle()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.clear)
                            .overlay(
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .foregroundColor(Color("Gray200"))
                                    .frame(width: 21, height: 5)
                            )
                            .padding(.trailing, 20)
                    } //Menu닫기
                    
                } //HStack닫기
                .padding(.top, 12)
                
                Divider()
                    .overlay(Color("Gray100"))
                    .opacity(item == array.last ? 0 : 1)
                
            } //VStack닫기
            .padding(.leading, 20)
            
        } //ForEach닫기
        
    } //itemList닫기
    
} //struct닫기

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
