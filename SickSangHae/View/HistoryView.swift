//
//  HistoryView.swift
//  SickSangHae
//
//  Created by kimsangwoo on 2023/07/17.
//

import SwiftUI

struct HistoryView: View {
    
    @State var isEatenTab = true
    @State var isShowingCenterAlertView = false
    @State var isDeletingItem = false
    @State var selectedItem: Receipt?
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("식기록")
                        .font(.pretendard(.bold, size: 28))
                        .foregroundColor(Color("PrimaryGB"))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                .padding(.vertical, 20)
                
                segmentedTabButton
                    .padding(.horizontal, 20)
                
                Rectangle()
                    .foregroundColor(.gray100)
                    .frame(height: 1)
                
                ScrollView {
                    listSection
                } //ScrollView닫기
                .listStyle(.plain)
            } //VStack닫기
            
        CenterAlertView(
            titleMessage: "식료품 삭제",
            bodyMessage: selectedItem?.name ?? "알수없음",
            actionButtonMessage: "삭제",
            isShowingCenterAlertView: $isShowingCenterAlertView,
            isDeletingItem: $isDeletingItem
        )
            .opacity(isShowingCenterAlertView ? 1 : 0)
            .onChange(of: isDeletingItem) { _ in
                if isDeletingItem {
                    coreDataViewModel.deleteReceiptData(target: selectedItem)
                    isDeletingItem = false
                }
            }
        } //ZStack닫기
    } //body닫기
    
    var segmentedTabButton: some View {
        ZStack(alignment: .bottom) {
            HStack {
                // 먹었어요 탭 버튼
                VStack(spacing: 0) {
                    Spacer()
                    
                    Button(action: {
                        isEatenTab = true
                    }, label: {
                        Text("먹었어요😋")
                            .font(.pretendard(.bold, size: 20))
                            .foregroundColor(Color("Gray900"))
                    }) //Button닫기
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(isEatenTab ? Color("PrimaryGB") : .clear)
                        .frame(width: screenWidth * 0.4, height: 3)
                } //VStack닫기
                
                // 상했어요 탭 버튼
                VStack(spacing: 0) {
                    Spacer()
                    
                    Button(action: {
                        isEatenTab = false
                    }, label: {
                        Text("상했어요🤢")
                            .font(.pretendard(.bold, size: 20))
                            .foregroundColor(Color("Gray900"))
                    }) //Button닫기
                    
                    Spacer()
                    
                    Rectangle()
                        .foregroundColor(isEatenTab ? .clear : Color("PrimaryGB"))
                        .frame(width: screenWidth * 0.4, height: 3)
                } //VStack닫기
            } //HStack닫기
        } //ZStack닫기
        .frame(height: 52)
    } //segmentedTabButton닫기
    
    var listSection: some View {
        var targetDictionary: [String : [Receipt]] = [String : [Receipt]]()
        var keys: [String] = [String]()
        
        if isEatenTab {
            targetDictionary = coreDataViewModel.eatenDictionary
            keys = Array(targetDictionary.keys.sorted(by: >))
        } else {
            targetDictionary = coreDataViewModel.spoiledDictionary
            keys = Array(targetDictionary.keys.sorted(by: >))
        }
        
        return ForEach(keys, id:\.self) { key in
            VStack {
                Rectangle()
                    .foregroundColor(.gray100)
                    .frame(height: 12)
                listTitle(itemDictionary: targetDictionary, key: key)
                itemList(itemDictionary: targetDictionary, key: key)
            }
        }
    } //listSection닫기
    
    func listTitle(itemDictionary: [String: [Receipt]], key: String) -> some View {
        HStack {
            Text(key)
                .foregroundColor(Color("Gray900"))
                .font(.pretendard(.semiBold, size: 20))
            
            Spacer()
        } //HStack닫기
        .padding(.vertical, 17)
        .padding(.horizontal, 20)
    } //listTitle닫기
    
    func itemList(itemDictionary: [String: [Receipt]], key: String) -> AnyView {
        guard let itemList = itemDictionary[key] else { return AnyView(EmptyView()) }
        
        return AnyView(
            ForEach(itemList, id:\.self) { item in
                VStack {
                    HStack {
                        Image(item.icon)
                            .resizable()
                            .foregroundColor(Color("Gray200"))
                            .frame(width: 36, height: 36)
                            .padding(.trailing, 12)
                        
                        Text(item.name)
                            .font(.pretendard(.semiBold, size: 17))
                            .foregroundColor(Color("Gray900"))
                        
                        Spacer()
                        
                        menuButtons(item: item)
                    } //HStack닫기
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                } //VStack닫기
            } //ForEach닫기
        ) //AnyView닫기
    } //itemList닫기
    
    func menuButtons(item: Receipt) -> some View {
        Menu {
            Button(action: {
                //아이템 상태 복구 로직
                coreDataViewModel.recoverPreviousStatus(target: item)
            }, label: {
                Text("복구하기")
                Image(systemName: "arrow.counterclockwise")
            })
            
            Divider()
            
            Button(role: .destructive, action: {
                selectedItem = item
                withAnimation(.easeInOut(duration: 0.2)) {
                    isShowingCenterAlertView = true
                }
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
        } //Menu닫기
    } //menuButtons닫기
} //struct닫기

struct HistoryView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        HistoryView()
            .environmentObject(coreDataViewModel)
    }
}
