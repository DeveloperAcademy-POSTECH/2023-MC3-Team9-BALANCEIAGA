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
                //버튼 및 타이틀
                Spacer()
                    .frame(height: 32)
                
                HStack {
                    Text("보관함")
                        .font(.pretendard(.bold, size: 28))
                        .foregroundColor(Color("PrimaryGB"))
                        .padding(.horizontal, 20)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 20)
                
                segmentedTabButton
                    .padding(.horizontal, 20)
//
                
                ScrollView {
                    deleteNotiMessage
                    
                    listSection
                    
                    
                } //ScrollView닫기
                .listStyle(.plain)
                

            } //VStack닫기
            
        CenterAlertView(titleMessage: "식료품 삭제", bodyMessage: selectedItem?.name ?? "알수없음", actionButtonMessage: "삭제", isShowingCenterAlertView: $isShowingCenterAlertView, isDeletingItem: $isDeletingItem)
                .opacity(isShowingCenterAlertView ? 1 : 0)
            .onChange(of: isDeletingItem) { _ in
                if isDeletingItem {
                    coreDataViewModel.deleteReceiptData(target: selectedItem)
                    isDeletingItem = false
                }
            }
        }
    } //body닫기
    
    var segmentedTabButton: some View {
        HStack {
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

                RoundedRectangle(cornerRadius: 1.5)
                    .foregroundColor(isEatenTab ? Color("PrimaryGB") : .clear)
                    .frame(width: 155, height: 3)
            } //VStack닫기
            
            Spacer()
                .frame(minWidth: 10, maxWidth: 40)
            
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
                
                RoundedRectangle(cornerRadius: 1.5)
                    .foregroundColor(isEatenTab ? .clear : Color("PrimaryGB"))
                    .frame(width: 155, height: 3)
            } //VStack닫기
        } //HStack닫기
        .frame(height: 52)
    } //segmentedTabButton닫기
    
    
    var deleteNotiMessage: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 24)
            
            Text("아래의 항목들은 이곳에서 90일 동안 보관됩니다. 각 항목들은 90일이 지나면 영구적으로 삭제됩니다.")
                .font(.pretendard(.regular, size: 14))
                .foregroundColor(Color("Gray600"))
            
        } //VStack닫기
        .padding(.horizontal, 18)
        
    } //deleteNotiMessage닫기
    
    
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
                    .foregroundColor(.clear)
                    .frame(width: screenWidth, height: 12)
                    .background(Color("Gray100"))
                
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
            
            Text("\(itemDictionary[key]?.first?.dateOfHistory.remainingDate ?? "90")일 남음")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("Gray600"))
            
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
                    
                    Spacer()
                        .frame(width: 12)
                    
                    Text(item.name)
                        .font(.pretendard(.semiBold, size: 17))
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                    
                    menuButtons(item: item)

                    Divider()
                        .overlay(Color("Gray100"))
                        .opacity(item == itemList.last ? 0 : 1)

                } //HStack닫기
                .padding(.leading, 20)
            } //VStack닫기
        } //ForEach닫기
        )

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
                .padding(.trailing, 20)
        } //Menu닫기
    }
    
} //struct닫기

struct HistoryView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        HistoryView()
            .environmentObject(coreDataViewModel)
    }
}
