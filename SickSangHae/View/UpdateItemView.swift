//
//  UpdateItemView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/17.
//

import SwiftUI

struct UpdateItemView: View {
  @ObservedObject var viewModel: UpdateItemViewModel
  
  var body: some View {
    VStack {
      topBar
      Spacer().frame(height: 36.adjusted)
      DateSelectionView(viewModel: viewModel)
      Spacer().frame(height: 30.adjusted)
      ZStack(alignment: .top) {
        VStack {
          ItemBlockView()
          addItemButton
          Spacer()
          nextButton
        }
        if viewModel.isDatePickerOpen {
          DatePickerView(viewModel: viewModel)
        }
      }
    }
  }
  
  private var topBar: some View {
    HStack {
      Image(systemName: "chevron.left")
        .resizable()
        .frame(width: 10, height: 19)
      Spacer()
      Text("직접 추가")
        .fontWeight(.bold)
        .font(.system(size: 17))
      Spacer()
      Image(systemName: "xmark")
        .resizable()
        .frame(width: 15, height: 15)
    }
    .padding([.leading, .trailing], 20.adjusted)
  }
  
  private var addItemButton: some View {
    ZStack {
      Rectangle()
        .frame(width: 350, height: 60)
        .foregroundColor(.lightGrayColor)
        .cornerRadius(12)
      
      HStack {
        Image(systemName: "plus")
        Text("품목 추가하기")
      }
      .bold()
      .foregroundColor(.accentColor)
    }
    .padding(.top, 15)
  }
  
  private var nextButton: some View {
    ZStack {
      Rectangle()
        .frame(width: 350, height: 60)
        .foregroundColor(.lightGreenGrayColor)
        .cornerRadius(12)
      
      HStack {
        Text("다음")
          .foregroundColor(.white)
          .bold()
      }
    }
    .padding(.bottom, 30)
  }
}

struct UpdateItemView_Previews: PreviewProvider {
  static var previews: some View {
    UpdateItemView(viewModel: UpdateItemViewModel())
  }
}
