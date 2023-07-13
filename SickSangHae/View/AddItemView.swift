//
//  AddItemView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds

struct AddItemView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 155)
                Text("직접 추가")
                    .fontWeight(.bold)
                    .font(.title2)
                Spacer().frame(width: 120)
                Image(systemName: "xmark")
                    .frame(width: 15.5, height: 15.5)
                  
            }.padding(.trailing, 20)
            
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 8, height: 14.2)
                
                Text("2023년 7월 5일")
                    .fontWeight(.bold)
                    .padding(34)
                
                Image(systemName: "chevron.right")
                    .frame(width: 8, height: 14.2)
                    .foregroundColor(.lightGrayColor)
                    
            }
            
            ItemBlockView()
            
            
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 60)
                    .foregroundColor(.tempGrayColor)
                    .cornerRadius(12)
                HStack {
                    Image(systemName: "plus")
                    Text("품목 추가하기")
                }
                
            }
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 60)
                    .foregroundColor(.tempGrayColor)
                    .cornerRadius(12)
                HStack {
                    Text("완료")
                        .foregroundColor(.lightGrayColor)
                }
                
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
