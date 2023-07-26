//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
    let id = UUID()
    
    class Name: ObservableObject {
        @Published var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    class Price: ObservableObject {
        @Published var price: Int
        
        init(price: Int) {
            self.price = price
        }
    }
    
    @ObservedObject var name = Name(name: "")
    @ObservedObject var price = Price(price: 0)
    
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
                TextField("무엇을 구매했나요?", text: $name.name)
            }
            Divider().foregroundColor(.gray100)
            HStack(spacing: 28.adjusted) {
                Text("금액")
                    .padding(.leading,20)
                TextField("얼마였나요?", value: $price.price, formatter: UpdateItemViewModel.priceFormatter)
                    .keyboardType(.numberPad)
            }
        }
      }
      .frame(height: 116.adjusted)
      Spacer().frame(height: 10)
      if viewModel.isShowTextfieldWarning && !viewModel.areBothTextFieldsNotEmpty {
        Text("\(viewModel.showTextfieldStatus)을 입력하세요.")
          .font(.system(size: 14))
          .foregroundColor(.pointR)
          .padding(.leading, 20.adjusted)
    }
    .padding(.horizontal, 20.adjusted)

extension ItemBlockView: Hashable, Equatable {
    static func == (lhs: ItemBlockView, rhs: ItemBlockView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}

struct ItemBlockView_Previews: PreviewProvider {
  static var previews: some View {
      ItemBlockView(viewModel: UpdateItemViewModel())
  }
}



