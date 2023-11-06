//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
    let id = UUID()
    
    @ObservedObject var itemBlockViewModel: ItemBlockViewModel
    @ObservedObject var viewModel: UpdateItemViewModel
    
    init(viewModel: UpdateItemViewModel, itemBlockViewModel: ItemBlockViewModel) {
        self.viewModel = viewModel
        self.itemBlockViewModel = itemBlockViewModel
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Spacer()
                Button {
                    deleteItem()
                } label: {
                    VStack {
                        Image(systemName: "trash.fill")
                            .padding(.bottom, 4)
                        
                        Text("삭제")
                            .font(.pretendard(.semiBold, size: 14))
                    }
                    .frame(width: 90.adjusted, height: 116.adjusted)
                }
                .background(Color("PointR"))
                .foregroundColor(.white)
                .opacity(itemBlockViewModel.offset < 0 ? 1 : 0)
            }
            .onTapGesture {
                    withAnimation {
                        itemBlockViewModel.offset = 0.0
                    }
                }

            Group {
                
                HStack{
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(maxHeight: 5)
                    
                    TextField("무엇을 구매했나요?", text: $itemBlockViewModel.name)
                        .font(.pretendard(.semiBold, size: 17))
                        .foregroundColor(Color.gray900)
                    
                    TextField("얼마였나요?", value: $itemBlockViewModel.price, formatter: UpdateItemViewModel.priceFormatter)
                        .keyboardType(.numberPad)
                        .font(.pretendard(.semiBold, size: 14))
                        .foregroundColor(Color.gray400)
                    
//                    Spacer().frame(height: 10)
                    
//                    if !itemBlockViewModel.areBothTextFieldsNotEmpty {
//                        Text("\(viewModel.showTextfieldStatus)을 입력하세요.")
//                            .font(.pretendard(.regular, size: 14))
//                            .foregroundColor(.pointR)
//                            .padding(.leading, 20.adjusted)
//                    }
                }
                    Button {
//                            isShowingUpdateItemView = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color("Gray100"))
                            
                            Text("편집")
                                .foregroundColor(Color("Gray600"))
                                .font(.pretendard(.regular, size: 14.adjusted))
                        }
                        .frame(width: 60, height: 32)
                        .foregroundColor(Color("Gray600"))
                    }
            }
            }
        .frame(height: 116.adjusted)
        .offset(x: itemBlockViewModel.offset)
        }
        .padding(.horizontal, 24.adjusted)
    }
}
extension ItemBlockView: Hashable, Equatable {
    static func == (lhs: ItemBlockView, rhs: ItemBlockView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    func deleteItem() {
        withAnimation(.easeInOut(duration: 0.5)) {
            viewModel.isShowTopAlertView = false
            viewModel.deleteItemBlock(itemBlockViewModel: itemBlockViewModel)
        }
    }
}

class ItemBlockViewModel: ObservableObject, Equatable, Hashable {
    let id = UUID()
    @Published var name: String
    @Published var price: Int
    @Published var offset: CGFloat = 0
    @Published var isShowTextfieldWarning = false
    
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



