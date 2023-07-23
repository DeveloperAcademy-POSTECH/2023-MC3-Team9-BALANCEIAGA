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
      
      Spacer().frame(height: 36.adjusted)
      HStack(spacing: 24) {
        Button(action: {
          viewModel.decreaseDate()
          
        }, label: {
          Image(systemName: "chevron.left")
            .resizable()
            .frame(width: 8, height: 14)
          
        })
        Button(action: {
          viewModel.isDatePickerOpen.toggle()
        }, label: {
          Text("\(viewModel.date, formatter: UpdateItemViewModel.dateFormat)")
            .font(.system(size: 20).bold())
          
        })
        Button(action: {
          viewModel.increaseDate()
        }, label: {
          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 14)
          
        })
        .foregroundColor(viewModel.date < viewModel.todayDate ? .black : .gray)
        
      }
      .foregroundColor(.black)
      
      Spacer().frame(height: 30.adjusted)
      ZStack(alignment: .top) {
        VStack {
          ItemBlockView()
          
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
   
          Spacer()
          
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
        
        if viewModel.isDatePickerOpen {
          ZStack {
            Rectangle()
              .cornerRadius(12)
              .foregroundColor(.white)
              .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
            
            GeometryReader { geo in
              
              DatePicker (
                "\(viewModel.date, formatter: UpdateItemViewModel.dateFormat)",
                selection: $viewModel.date,
                in: ...Date(),
                displayedComponents: .date
              )
              .labelsHidden()
              .datePickerStyle(GraphicalDatePickerStyle())
              .frame(width: geo.size.width, height: geo.size.height)
              .onChange(of: viewModel.date) { _ in
                viewModel.isDatePickerOpen = false
                
              }
              
            }
            .padding(.all, 20)
          }
          .frame(height: screenHeight / (2.6).adjusted)
          .padding([.leading, .trailing], 14.adjusted)
          
        }
      }
    }
  }
  
}
  struct UpdateItemView_Previews: PreviewProvider {
    static var previews: some View {
      UpdateItemView(viewModel: UpdateItemViewModel())
    }
  }
  
