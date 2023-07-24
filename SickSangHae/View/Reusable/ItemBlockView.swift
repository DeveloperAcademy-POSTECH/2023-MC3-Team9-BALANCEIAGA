//
//  ItemBlockView.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct ItemBlockView: View {
  @ObservedObject var viewModel: UpdateItemViewModel
  var body: some View {
    VStack(alignment: .leading) {
      ZStack(alignment: .trailing) {
        Rectangle()
          .foregroundColor(.lightGrayColor)
          .cornerRadius(12)
        VStack(alignment: .leading) {
          HStack(spacing: 28.adjusted) {
            Text("품목")
              .padding(.leading,20)
            TextField("무엇을 구매했나요?", text: $viewModel.name)
          }
          Divider().foregroundColor(.gray100)
          HStack(spacing: 28.adjusted) {
            Text("금액")
              .padding(.leading, 20)
            TextField("얼마였나요?",
                      text: $viewModel.priceString, onEditingChanged: { editing in
              if !editing {
                viewModel.priceInt = Int(viewModel.priceString) ?? 0
                viewModel.priceString = UpdateItemViewModel.priceFormatter.string(from: NSNumber(value: viewModel.priceInt)) ?? ""
              }
              
            })
            .keyboardType(.numberPad)
          }
        }
        VStack {
          Button(action: {
            viewModel.isShowTopAlertView = true
          }, label: {
            Image(systemName: "xmark.circle.fill")
              .resizable()
              .frame(width:25 ,height:25)
              .foregroundColor(.lightBlueGrayColor)
          })
          Spacer()
        }
        .padding(.trailing, 16.adjusted)
        .padding(.top, 14.adjusted)
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
    .padding([.leading,.trailing], 20.adjusted)

  }
}



