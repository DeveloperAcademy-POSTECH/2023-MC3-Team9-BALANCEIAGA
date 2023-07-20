//
//  BasicList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct BasicList: View {
    
    var body: some View {
        VStack {
            List {
                PinnedListTitle(title: "빨리 먹어야 해요 🕖")
                ListContent()
            
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 390.adjusted, height: 12.adjusted)
            .background(.gray)
//            .background("Gray100")
                BasicListTitle(title: "기본")
                ListContent()
            }
            .listStyle(.plain)
        }
    }
}

private struct BasicListTitle: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
//                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted))
            
            Spacer()
            
            Button {
                
            } label: {
                HStack(spacing: 2.adjusted) {
                    Text("최신순")
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
//            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14.adjusted))
        }
    }
}

private struct PinnedListTitle: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
//                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted))
            
            Spacer()
        }
    }
}


private struct ListContent: View {
    let itemList: [Receipt] = []
    var body: some View {
        VStack {
            ForEach(itemList, id: \.self) { receipt in
                HStack {
                    Text("")
                        .foregroundColor(.clear)
                    
                    Image(systemName: "circle.fill")
                        .resizable()
                    //                .foregroundColor(Color("Gray200"))
                        .frame(width: 36.adjusted, height: 36.adjusted)
                    
                    Text(receipt.name)
                        .foregroundColor(.clear)
                    
                    Spacer()
                    
                    Text("구매한지 x일")
                    //                .foregroundColor(Color("Gray900"))
                        .font(.system(size: 14.adjusted))
                }
            }
        }
    }
}

struct BasicList_Previews: PreviewProvider {
    static var previews: some View {
        BasicList()
    }
}
