//
//  UpdateItemView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/17.
//

import SwiftUI

struct UpdateItemView: View {
    
    @Namespace var bottomID
    
  @ObservedObject var viewModel: UpdateItemViewModel
    @State private var itemBlockViews: [ItemBlockView] = [ItemBlockView]()
    
    @State var swipeOffsets: [CGFloat] = [CGFloat]()
    
  var body: some View {
    ZStack {
      Color.white
        .ignoresSafeArea(.all)
      VStack {
        topBar
        Spacer().frame(height: 36.adjusted)
        DateSelectionView(viewModel: viewModel)
        Spacer().frame(height: 30.adjusted)
        ZStack(alignment: .top) {
          VStack {
              ScrollViewReader { proxy in
                  ScrollView(.vertical) {
                      VStack {
                          ForEach(Array(zip(itemBlockViews.indices, itemBlockViews)), id: \.0) { index, element in
                              ZStack {
                                      element
                                      .onTapGesture {
                                          withAnimation {
                                              swipeOffsets[index] = 0
                                          }
                                      }
                                      .offset(x: swipeOffsets[index])
                                      HStack {
                                          Spacer()
                                          Button {
                                              deleteItemBlockView(index)
                                          } label: {
                                              VStack {
                                                  Image(systemName: "trash.fill")
                                                      .padding(.bottom, 4)
                                                  
                                                  Text("삭제")
                                                      .font(.system(size: 14, weight: .semibold))
                                              }
                                                      .frame(width: 90.adjusted, height: 116.adjusted)
                                          }
                                          
                                          .background(Color("PointR"))
                                          .foregroundColor(.white)
                                          .clipShape(RoundedRectangle(cornerRadius: 12))
                                          .padding(.trailing, 20.adjusted)
                                                                                    
                                          .opacity(swipeOffsets[index] < 0 ? 1 : 0)
                                      }
                                      
                              }
                              .gesture(DragGesture().onChanged({ value in
                                  withAnimation {
                                      if value.translation.width < 0 {
                                          swipeOffsets[index] = value.translation.width
                                      }
                                  }
                              })
                                .onEnded({ value in
                                    withAnimation {
                                        if value.translation.width < -90 {
                                            swipeOffsets[index] = -100
                                        } else {
                                            swipeOffsets[index] = 0
                                        }
                                    }
                                }))
                                  
                          }
                          
                          
                          .onChange(of: itemBlockViews) { _ in
                              withAnimation {
                                  proxy.scrollTo(bottomID, anchor: .bottom)
                              }
                          }
                          addItemButton
                            .onTapGesture {
                                withAnimation {
                                    addItemBlockView()
                                }
                            }
                            .id(bottomID)
                      }
                  }
              }
            Spacer()
            nextButton
                  .onTapGesture {
                      registerItemBlockViews()
                  }
          }
          if viewModel.isDatePickerOpen {
            DatePickerView(viewModel: viewModel)
          }
        }
      }
    }
    .onTapGesture {
      self.endTextEditing()
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
//    .padding(.top, 10)
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

extension UpdateItemView {
  struct DateSelectionView: View {
    @ObservedObject var viewModel: UpdateItemViewModel
    
    var body: some View {
      HStack(spacing: 24) {
        Button(action: {
          viewModel.decreaseDate = viewModel.date
        }, label: {
          Image(systemName: "chevron.left")
            .resizable()
            .frame(width: 8, height: 14)
        })
        
        Button(action: {
          viewModel.isDatePickerOpen.toggle()
        }, label: {
          Text("\(viewModel.dateString)")
            .font(.system(size: 20).bold())
        })
        
        Button(action: {
          viewModel.increaseDate = viewModel.date
        }, label: {
          Image(systemName: "chevron.right")
            .resizable()
            .frame(width: 8, height: 14)
        })
        .foregroundColor(viewModel.isDateBeforeToday ? .black : .gray)
      }
      .foregroundColor(.black)
    }
  }
  
  struct DatePickerView: View {
    @ObservedObject var viewModel: UpdateItemViewModel
    
    var body: some View {
      ZStack {
        Rectangle()
          .cornerRadius(12)
          .foregroundColor(.white)
          .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 4)
        
        GeometryReader { geo in
          DatePicker(
            viewModel.dateString,
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
    
    func addItemBlockView() {
        itemBlockViews.append(ItemBlockView(viewModel: viewModel))
        swipeOffsets.append(CGFloat(0))
    }
    
    func deleteItemBlockView(_ offset:Int) {
        itemBlockViews.remove(at: offset)
        swipeOffsets.remove(at: offset)
    }
    
    func registerItemBlockViews() {
        for i in 0..<itemBlockViews.count {
            // TODO: CoreData 연결
        }
    }
}

struct UpdateItemView_Previews: PreviewProvider {
  static var previews: some View {
    UpdateItemView(viewModel: UpdateItemViewModel())
  }
}
