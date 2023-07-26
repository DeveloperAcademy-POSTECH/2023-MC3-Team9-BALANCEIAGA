//
//  BasicList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct BasicList: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    var body: some View {
        ScrollView {
            PinnedListTitle(title: "빨리 먹어야 해요 🕖")
            ListContent(itemList: coreDataViewModel.shortTermPinnedList, swipeOffsets: coreDataViewModel.shortTermPinnedOffsets, status: .shortTermPinned)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: screenWidth, height: 12)
                .background(Color("Gray100"))
            
            BasicListTitle(title: "기본")
            ListContent(itemList: coreDataViewModel.shortTermUnEatenList, swipeOffsets: coreDataViewModel.shortTermUnEatenOffsets, status: .shortTermUnEaten)
        }
        .listStyle(.plain)
        
    }
}

private struct BasicListTitle: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20).weight(.semibold))
            
            Spacer()
            
            Button {
                
            } label: {
                HStack(spacing: 2) {
                    Text("최신순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14))
            .padding(.trailing, 20)
        }
        .padding([.top, .bottom], 17)
        .padding([.leading], 20)
    }
}

private struct PinnedListTitle: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20).weight(.semibold))
            
            Spacer()
        }
        .padding([.top, .bottom], 17)
        .padding([.leading, .trailing], 20)
    }
}


private struct ListContent: View {
    let itemList: [Receipt] = []
    let data = ["Apple", "Banana", "Orange", "Pineapple", "Grapes", "Watermelon", "Mango", "Papaya", "Cherry"]
    
    var body: some View {
        ForEach(data, id:\.self) { item in
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("")
                        .foregroundColor(.clear)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color("Gray200"))
                        .frame(width: 36.adjusted, height: 36.adjusted)
                    
                    Spacer()
                        .frame(width: 12.adjusted)
                    
                    Text(item)
                        .font(.system(size: 17.adjusted).weight(.semibold))
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                    
                    Text("구매한지 x일")
                        .foregroundColor(Color("Gray900"))
                        .font(.system(size: 14.adjusted).weight(.semibold))
                        .padding(.trailing, 20.adjusted)
                }
                .padding([.top, .bottom], 8.adjusted)
            }
            
            Divider()
                .overlay(Color("Gray100"))
                .opacity(item == data.last ? 0 : 1)
        }
        .padding([.leading], 20.adjusted)
    }
}

struct BasicList_Previews: PreviewProvider {
    static var previews: some View {
        BasicList()
    }
}
