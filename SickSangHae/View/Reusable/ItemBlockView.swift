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
    @State var isShowingconfirmationDialog = false
    @State var isShowingEditModal = false
    @State private var isNameButtonEnabled = false
    @State private var isPriceButtonEnabled = false
    
    init(viewModel: UpdateItemViewModel, itemBlockViewModel: ItemBlockViewModel) {
        self.viewModel = viewModel
        self.itemBlockViewModel = itemBlockViewModel
    }
    
    var body: some View {
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
                    
                }
                Button {
                    isShowingconfirmationDialog = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 8)
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
        .padding(.horizontal, 24.adjusted)
        .padding(.top, 23)
        .confirmationDialog("Confirmation Dialog", isPresented: $isShowingconfirmationDialog, actions: {
            Button("수정하기", action: {
                self.isShowingEditModal = true
            })
                .font(.pretendard(.regular, size: 17.adjusted))
            Button("항목 삭제", role: .destructive, action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                           viewModel.isShowTopAlertView = false
                           viewModel.deleteItemBlock(itemBlockViewModel: itemBlockViewModel)
                       }
            })
                .font(.pretendard(.regular, size: 17.adjusted))
            Button("취소", role: .cancel, action: {
                isShowingconfirmationDialog = false
            })
                .font(.pretendard(.bold, size: 17))
        })
        .sheet(isPresented: self.$isShowingEditModal) {
            editModalView
        }
    }
    
    private var editModalView: some View {
        VStack(alignment: .leading) {
            
            Image(systemName: "minus")
                .frame(maxWidth: 36, maxHeight: 5)
                .padding(.top, 12)
            
            topBar
                .padding(.bottom, 40)
                .padding(.top, 24)
            
            Text("품목명")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
                .padding(.leading, 8)
            
            HStack(spacing: 20.adjusted) {
                TextField("무엇을 구매했나요?", text: $itemBlockViewModel.name)
                
                Spacer()
                
                Button {
                    itemBlockViewModel.name = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray400)
                }
                .disabled(itemBlockViewModel.name.isEmpty)
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color("Gray50"))
            .cornerRadius(12)
            
            Text("구매금액")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
                .padding(.leading, 8)
            
            HStack(spacing: 20.adjusted) {
                
                TextField("얼마였나요?", value: $itemBlockViewModel.price, formatter: UpdateItemViewModel.priceFormatter)
                    .keyboardType(.numberPad)
                
                Spacer()
                Button {
                    itemBlockViewModel.price = 0
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray400)
                }
                .disabled(itemBlockViewModel.price == 0)
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color("Gray50"))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    private var topBar: some View {
        HStack {
            Button(action:{
                isShowingEditModal = false
            }, label: {
                Text("취소")
                    .foregroundColor(Color.primaryGB)
                    .font(.pretendard(.semiBold, size: 17))
            })
            Spacer()
            Text("품목 수정")
                .font(.pretendard(.bold, size: 17))
            Spacer()
            Button(action: {
                if (!itemBlockViewModel.name.isEmpty && itemBlockViewModel.price != 0) {
                    isShowingEditModal = false
                    viewModel.editItemBlock(itemBlockViewModel: itemBlockViewModel, name: itemBlockViewModel.name, price: itemBlockViewModel.price)
                }
            } , label: {
                if (!itemBlockViewModel.name.isEmpty && itemBlockViewModel.price != 0){
                    Text("완료")
                        .foregroundColor(Color.primaryGB)
                        .font(.pretendard(.semiBold, size: 17))
                } else {
                    Text("완료")
                        .foregroundColor(Color.gray200)
                        .font(.pretendard(.semiBold, size: 17))
                }
            })
        }
        .foregroundColor(.gray900)
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
      ScrollView{
          ItemBlockView(viewModel: UpdateItemViewModel(), itemBlockViewModel: ItemBlockViewModel(name: "", price: 0))
          ItemBlockView(viewModel: UpdateItemViewModel(), itemBlockViewModel: ItemBlockViewModel(name: "", price: 0))
      }
  }
}



