//
//  AddItemView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct AddItemView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("직접 추가")
                    .fontWeight(.bold)
                    .font(.title2)
                
                Image(systemName: "xmark")
                    .frame(width: 15.5, height: 15.5)
                    .padding(.leading, 123)
            }
            .padding(.trailing, 22)
            
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 8, height: 14.2)
                
                Text("2024년 7월 5일")
                    .fontWeight(.bold)
                    .padding(34)
                
                Image(systemName: "chevron.right")
                    .frame(width: 8, height: 14.2)
                    
                    
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
