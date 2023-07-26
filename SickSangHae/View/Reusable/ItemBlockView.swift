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
        .frame(height: 116.adjusted)
        Spacer().frame(height: 10)
        if viewModel.isShowTextfieldWarning && !viewModel.areBothTextFieldsNotEmpty {
            Text("\(viewModel.showTextfieldStatus)을 입력하세요.")
                .font(.system(size: 14))
                .foregroundColor(.pointR)
                .padding(.leading, 20.adjusted)
        }
    }
        .padding(.horizontal, 20.adjusted)
    }
        
}
extension ItemBlockView: Hashable, Equatable {
    static func == (lhs: ItemBlockView, rhs: ItemBlockView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    func deleteItem() {
        viewModel.isShowTopAlertView = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 1)) {
                viewModel.isShowTopAlertView = false
                viewModel.deleteItemBlock(itemBlockViewModel: itemBlockViewModel)
            }
        }
    }
}

class ItemBlockViewModel: ObservableObject, Equatable, Hashable {
    let id = UUID()
    @Published var name: String
    @Published var price: Int
    @Published var offset: CGFloat = 0
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
    
    var priceString: String {
        return String(price)
    }
    
    var isAnyTextFieldEmpty: Bool {
      return name.isEmpty || priceString.isEmpty
    }
    
    var areBothTextFieldsNotEmpty: Bool {
      return !name.isEmpty && !priceString.isEmpty
    }
    
    
    var showTextfieldStatus: String {
      switch (priceString.isEmpty, name.isEmpty) {
      case (true, true):
        return "상품명과 금액"
      case (true, false):
        return "금액"
      case (false, true):
        return "상품명"
      case (false, false):
        return ""
      }
    }
    
    
    static func == (lhs: ItemBlockViewModel, rhs: ItemBlockViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}


struct ItemBlockView_Previews: PreviewProvider {
  static var previews: some View {
      ItemBlockView(viewModel: UpdateItemViewModel(), itemBlockViewModel: ItemBlockViewModel(name: "", price: 0))
  }
}



