//
//  DirectUpdateItemView.swift
//  SickSangHae
//
//  Created by user on 2023/07/30.
//

import SwiftUI

struct DirectUpdateItemView: View {
    @Namespace var bottomID
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UpdateItemViewModel
    @State private var isItemCheckView = false
    @State var appState: AppState
    
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
            Text("직접 추가")
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
        NavigationLink {
//            viewModel.isShowTextfieldWarning = !viewModel.areBothTextFieldsNotEmpty
//            registerItemBlockViews()
            DirectItemCheckView(viewModel: viewModel, appState: appState)
        } label: {
            ZStack{
                Rectangle()
                    .background(Color("PrimaryGB"))
                    .cornerRadius(12)
                    .frame(height: 60.adjusted)
                    
                Text("등록")
                    .foregroundColor(.white)
                    .font(.system(size: 17))
            }
            .padding(.horizontal, 20.adjusted)
            .padding(.bottom, 30.adjusted)
        }
    }
}

extension DirectUpdateItemView {
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
                    .datePickerStyle(.wheel)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .onChange(of: viewModel.date) { _ in
                        viewModel.isDatePickerOpen = false
                    }
                }
                .padding(20)
            }
            .frame(height: screenHeight/(2.6))
            .padding(.horizontal, 15)
          }
        }
  
    
    func addItemBlockView() {
        viewModel.addNewItemBlock()
    }
    
    func registerItemBlockViews() {
        
    }
}

