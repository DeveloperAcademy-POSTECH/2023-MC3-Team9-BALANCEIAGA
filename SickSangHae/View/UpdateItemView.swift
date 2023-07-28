//
//  UpdateItemView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/17.
//

import SwiftUI

struct UpdateItemView: View {
    @Namespace var bottomID
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UpdateItemViewModel
    @State var titleName: String
    @State var buttonName: String
    @Binding var gptAnswer: [String:[Any]]
    @State private var isItemCheckView = false
    let appState: AppState
    
    var body: some View {
            ZStack(alignment: .top) {
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
                                        ForEach(viewModel.itemBlockViewModels, id: \.self) { item in
                                            ItemBlockView(viewModel: viewModel, itemBlockViewModel: item)
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged({ value in
                                                            withAnimation {
                                                                if value.translation.width < 0 {
                                                                    item.offset = value.translation.width
                                                                }
                                                            }
                                                        })
                                                        .onEnded({ value in
                                                            withAnimation {
                                                                if value.translation.width < -90 {
                                                                    item.offset = -100
                                                                } else {
                                                                    item.offset = 0
                                                                }
                                                            }
                                                        })
                                                )
                                        }
                                        .onChange(of: viewModel.itemBlockViewModels) { _ in
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
                        }
                        if viewModel.isDatePickerOpen {
                            DatePickerView(viewModel: viewModel)
                        }
                    }
                }
                
                if viewModel.isShowTopAlertView {
                    Group {
                        TopAlertView(viewModel: TopAlertViewModel(name: "파채", currentCase: .delete))
                            .transition(.move(edge: .top))
                    }
                    .opacity(viewModel.isShowTopAlertView ? 1 : 0)
                    .animation(.easeInOut(duration: 0.4))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1)) {
                            viewModel.isShowTopAlertView = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 1)) {
                                viewModel.isShowTopAlertView = false
                            }
                        }
                    }
                }
            }
            .onAppear {
                for i in 0..<gptAnswer["상품명"]!.count {
                    viewModel.makeInitialItemBlock(name: gptAnswer["상품명"]![i] as! String, price: gptAnswer["금액"]![i] as! Int)
                }
            }
            .onTapGesture {
                self.endTextEditing()
            }
        .navigationBarBackButtonHidden(true)
    }
    
    
    private var topBar: some View {
        HStack {
            Button(action:{dismiss()}, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 19)
            })
            Spacer()
            Text(titleName)
                .fontWeight(.bold)
                .font(.system(size: 17))
            Spacer()
            Button(action: {
                self.appState.moveToRootView = true
            } , label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 15, height: 15)
            })
        }
        .foregroundColor(.gray900)
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
        Button(action: {
            viewModel.isShowTextfieldWarning = !viewModel.areBothTextFieldsNotEmpty
            registerItemBlockViews()
//            isItemCheckView = true
            dismiss()
        }, label: {
            ZStack{
                Rectangle()
                    .cornerRadius(12)
                    .frame(height: 60.adjusted)
                Text(buttonName)
                    .foregroundColor(.white)
                    .font(.system(size: 17))
            }
            .padding([.leading, .trailing], 20.adjusted)
            .padding(.bottom, 30.adjusted)
        })
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
            .padding(20)
          }
        }
  
    
    func addItemBlockView() {
        viewModel.addNewItemBlock()
    }
    
    func registerItemBlockViews() {
        
        gptAnswer = ["상품명":[], "단가":[], "수량":[], "금액":[]]
        
        viewModel.itemBlockViewModels.forEach { item in
            gptAnswer["상품명"]!.append(item.name)
            gptAnswer["단가"]!.append(item.price)
            gptAnswer["수량"]!.append(1)
            gptAnswer["금액"]!.append(item.price)
        }
//        for i in 0..<viewModel.itemBlockViewModels.count {
//
//        }
    }
}


struct UpdateItemView_Previews: PreviewProvider {
    @State var testDict = ["상품명":[], "단가":[], "수량":[], "금액":[]]
  static var previews: some View {
      UpdateItemView(viewModel: UpdateItemViewModel(), titleName: "test", buttonName: "button", gptAnswer: .constant(["test": []]), appState: AppState())
  }
}
