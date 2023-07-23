//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
  @State var name: String = ""
  @State var price: String = ""
  var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 350, height: 116)
                .foregroundColor(.lightGrayColor)
                .cornerRadius(12)
            VStack(alignment: .leading) {
              HStack(spacing: 28.adjusted) {
                    Text("품목")
                        .padding(.leading,20)
                  TextField("무엇을 구매했나요?", text: $name)
      
                }
              Divider().foregroundColor(.gray100)
                    .frame(width: 350, height: 10)
                    .foregroundColor(.lightGrayColor)
                HStack(spacing: 28.adjusted) {
                    Text("금액")
                        .padding(.leading,20)
                  TextField("얼마였나요?", text: $price)
                }
            }
            .padding(.leading, 20.adjusted)
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width:25 ,height:25)
                .foregroundColor(.lightBlueGrayColor)
                .padding(.leading, 295)
                .padding(.bottom, 60)
        }
    }
}

struct ItemBlockView_Previews: PreviewProvider {
    static var previews: some View {
        ItemBlockView()
    }
}
