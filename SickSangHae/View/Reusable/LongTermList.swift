//
//  LongTermList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct LongTermList: View {
    @ObservedObject var coreDataViewModel: CoreDataViewModel
    @State private var isDescending = true
    
    let appState: AppState
    

    var body: some View {

        ScrollView {
            ListTitle
            longtermListContent(longTermList: ListContentViewModel(status: .longTermUnEaten, itemList: coreDataViewModel.longTermUnEatenList), isDesecending: isDescending)
        }
        .listStyle(.plain)
    }

    private var ListTitle: some View {
        HStack{
            Text("천천히 먹어도 돼요")
                .foregroundColor(Color("Gray900"))
                .font(.pretendard(.bold, size: 20))

            Spacer()

            Button{
                isDescending.toggle()
            } label: {
                HStack(spacing: 2){
                    Text(isDescending ? "최신순" : "오래된순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.pretendard(.medium, size: 14))
            .padding(.trailing, 20)
        }
        .padding([.top, .bottom], 17)
        .padding(.leading, 20)
    }
    
    func longtermListContent(longTermList: ListContentViewModel, isDesecending: Bool) -> some View {
        return ForEach(isDescending ? longTermList.itemList : longTermList.itemList.reversed(), id: \.self) { item in
            VStack {
                listCell(item: item, appState: appState)
                
                Divider()
                    .overlay(Color("Gray100"))
                    .opacity(item == longTermList.itemList.last ? 0 : 1)
                    .padding(.leading, 20)
            }
        }
    }
    
    func listCell(item: Receipt) -> some View {
        return VStack {
            NavigationLink {
                ItemDetailView(topAlertViewModel: TopAlertViewModel(name: item.name, changedStatus: item.currentStatus), receipt: item, appState: appState, needToEatASAP: item.currentStatus)
                    .environmentObject(coreDataViewModel)
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.white)
                    HStack(spacing: 0) {
                        Text("")
                            .foregroundColor(.clear)
                        
                        Image(item.icon)
                            .resizable()
                            .foregroundColor(Color("Gray200"))
                            .frame(width: 36, height: 36)
                            .padding(.leading, 20)
                        
                        Spacer()
                            .frame(width: 12)
                        
                        Text(item.name)
                            .font(.system(size: 17).weight(.semibold))
                            .foregroundColor(Color("Gray900"))
                            .frame(height: 17)
                        
                        Spacer()
                        
                        Text("구매한지 \(item.dateOfPurchase.dateDifference)일")
                            .foregroundColor(Color("Gray900"))
                            .font(.system(size: 14).weight(.semibold))
                            .padding(.trailing, 20)
                    }
                    .padding([.top, .bottom], 8)
                }
            }
        }
    }
}
