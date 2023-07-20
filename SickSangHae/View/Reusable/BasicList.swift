//
//  BasicList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct BasicList: View {
    
    var body: some View {
        ScrollView {
            PinnedListTitle(title: "빨리 먹어야 해요 🕖")
            ListContent()
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 390.adjusted, height: 12.adjusted)
                .background(Color("Gray200"))
                .padding(.top, -8.adjusted)
            
            BasicListTitle(title: "기본")
            ListContent()
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
                .font(.system(size: 20.adjusted))
            
            Spacer()
            
            Button {
                
            } label: {
                HStack(spacing: 2.adjusted) {
                    Text("최신순")
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14.adjusted))
        }
        .padding([.top, .bottom], 17.adjusted)
    }
}

private struct PinnedListTitle: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted))
            
            Spacer()
        }
        .padding([.top, .bottom], 17.adjusted)
    }
}


private struct ListContent: View {
    let itemList: [Receipt] = []
    let data = ["Apple", "Banana", "Orange", "Pineapple", "Grapes", "Watermelon", "Mango", "Papaya", "Cherry"]
    
    var body: some View {
        ForEach(data, id:\.self) { item in
            VStack(spacing: 0) {
                HStack {
                    Text("")
                        .foregroundColor(.clear)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                        .foregroundColor(Color("Gray200"))
                        .frame(width: 36.adjusted, height: 36.adjusted)
                    
                    Text(item)
                        .font(.system(size: 17.adjusted))
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                    
                    Text("구매한지 x일")
                        .foregroundColor(Color("Gray900"))
                        .font(.system(size: 14.adjusted))
                }
                .padding([.top, .bottom], 8.adjusted)
            }
            Divider()
        }
    }
}

struct BasicList_Previews: PreviewProvider {
    static var previews: some View {
        BasicList()
    }
}
