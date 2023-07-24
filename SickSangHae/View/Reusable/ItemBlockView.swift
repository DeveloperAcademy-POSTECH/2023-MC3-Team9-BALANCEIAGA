//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
  @State var name: String = ""
  @State var priceInt: Int = 0
  @State var priceString: String = ""
  @ObservedObject var viewModel: UpdateItemViewModel
  var body: some View {
    ZStack(alignment: .trailing) {
      Rectangle()
        .foregroundColor(.lightGrayColor)
        .cornerRadius(12)
      VStack(alignment: .leading) {
        HStack(spacing: 28.adjusted) {
          Text("품목")
            .padding(.leading,20)
          TextField("무엇을 구매했나요?", text: $name)
        }
        Divider().foregroundColor(.gray100)
        HStack(spacing: 28.adjusted) {
          Text("금액")
            .padding(.leading, 20)
          TextField("얼마였나요?",
                    text: $priceString, onEditingChanged: { editing in
            if !editing {
              priceInt = Int(priceString) ?? 0
              priceString = UpdateItemViewModel.priceFormatter.string(from: NSNumber(value: priceInt)) ?? ""
            }
            
          })
          .keyboardType(.numberPad)
        }
      }
      VStack {
        Image(systemName: "xmark.circle.fill")
          .resizable()
          .frame(width:25 ,height:25)
          .foregroundColor(.lightBlueGrayColor)
        
        Spacer()
      }
      .padding(.trailing, 16.adjusted)
      .padding(.top, 14.adjusted)
      
    }
    .frame(height: 116.adjusted)
    .padding([.leading,.trailing], 20.adjusted)
  }
}



