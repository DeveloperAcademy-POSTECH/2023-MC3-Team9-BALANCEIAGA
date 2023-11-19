//
//  UpdateItemView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/17.
//

import SwiftUI

struct OCRUpdateItemView: View {
    @Namespace var bottomID
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UpdateItemViewModel
    @Binding var gptAnswer: [String:[Any]]
    @State private var isItemCheckView = false
    @State private var isShowModal = false
    let appState: AppState
    
    @State var showCalendarModal = false
    
    //
    @State var itemBlockName = ""
    @State var itemBlockPrice: Int = 0
    @State private var showingDatePicker = false
    @State var dateText: Date
    
    var body: some View {
            ZStack(alignment: .top) {
                Color.white
                    .ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    topBar
                    Spacer().frame(height: 36.adjusted)
                    DateSelectionView(viewModel: viewModel, showCalendarModal: $showCalendarModal, name: $itemBlockName, price: $itemBlockPrice)
                    Spacer().frame(height: 30.adjusted)
                    ZStack(alignment: .top) {
                        VStack(spacing: 0) {
                            ScrollViewReader { proxy in
                                ScrollView(.vertical) {
                                    ForEach(viewModel.itemBlockViewModels, id: \.self) { item in
                                        ItemBlockView(viewModel: viewModel, itemBlockViewModel: item)
                                            .onChange(of: viewModel.itemBlockViewModels) { _ in
                                                withAnimation {
                                                    proxy.scrollTo(bottomID, anchor: .bottom)
                                                }
                                            }
                                    }
                                }
                            }
                            Spacer()
                            addItemButton
                                .onTapGesture {
                                    withAnimation {
                                        isShowModal = true
                                    }
                                }
                                .id(bottomID)
                            
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
        .sheet(isPresented: $showCalendarModal){
//            CalendarModalView(viewModel: viewModel, showCalendarModal: $showCalendarModal)
            dateField
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowModal){
            editModalView
                .onDisappear(){
                    itemBlockName = ""
                    itemBlockPrice = 0
                }
        }
    }
    
    
    private var topBar: some View {
        HStack {
            Button(action:{dismiss()}, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 19)
            })
            
            Spacer()
            
            Text("수정")
                .font(.pretendard(.bold, size: 17))
            
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
        .padding(.horizontal, 20)
        .padding(.top, 15)
    }
    
    private var addItemButton: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: 350, maxHeight: 60)
                .foregroundColor(Color.gray50)
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
                    .frame(maxWidth: 88.adjusted, maxHeight: 60.adjusted)
                Text("다음")
                    .foregroundColor(.white)
                    .font(.pretendard(.regular, size: 17))
            }
            .padding(.horizontal, 20.adjusted)
            .padding(.bottom, 30.adjusted)
        })
    }
    private var editModalView: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack{
                Spacer()
                RoundedRectangle(cornerRadius: CGFloat(2.5))
                    .frame(width: 36, height: 5)
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .padding(.top, 12)
                Spacer()
            }
            
            editTopBar
                .padding(.bottom, 40)
                .padding(.top, 8)
            
            Text("품목명")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
                .padding(.leading, 8)
                .padding(.bottom, 8)
            
            HStack(spacing: 20) {
                TextField("무엇을 구매했나요?", text: $itemBlockName)
                
                Spacer()
                
                if itemBlockName != ""{
                    Button {
                        itemBlockName = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray400)
                    }
                    .disabled(itemBlockName.isEmpty)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color.gray50)
            .cornerRadius(12)
            
            Text("구매금액")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
                .padding(.leading, 8)
                .padding(.bottom, 8)
                .padding(.top, 24)
            
            HStack(spacing: 20) {
                
                TextField("얼마였나요?", value: $itemBlockPrice, formatter: UpdateItemViewModel.priceFormatter)
                    .keyboardType(.numberPad)
                
                Spacer()
                if itemBlockPrice != 0{
                    Button {
                        itemBlockPrice = 0
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray400)
                    }
                    .disabled(itemBlockPrice == 0)
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color.gray50)
            .cornerRadius(12)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    private var editTopBar: some View {
        HStack {
            Button(action:{
                isShowModal = false
            }, label: {
                Text("취소")
                    .foregroundColor(Color.primaryGB)
                    .font(.pretendard(.semiBold, size: 17))
            })
            Spacer()
            Text("품목 추가")
                .font(.pretendard(.bold, size: 17))
            Spacer()
            Button(action: {
                if (!itemBlockName.isEmpty && itemBlockPrice != 0) {
                    isShowModal = false
                    addItemBlockView(name: itemBlockName, price: itemBlockPrice)
                }
            } , label: {
                if (!itemBlockName.isEmpty && itemBlockPrice != 0){
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
    
    private var dateField: some View {
        DatePicker("구매일자", selection: $viewModel.date, in: ...Date(), displayedComponents: .date)
            .presentationDetents([.medium])
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding(.horizontal, 10)
            .environment(\.locale, .init(identifier: "ko"))
            .onChange(of: dateText) { _ in
                showingDatePicker = false
//                viewModel.date = dateText
            }
    }
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: dateText)
    }
}

extension OCRUpdateItemView {
    struct CalendarModalView: View {
        @ObservedObject var viewModel: UpdateItemViewModel
        @Binding var showCalendarModal: Bool
        
        var body: some View {
            VStack(spacing: 0) {
                HStack(alignment: .center){
                    Text("날짜 바꾸기")
                        .font(.pretendard(.semiBold, size: 17))
                        .padding(.top, 41)
                }
                DatePicker("날짜 선택", selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .padding()
                    .onChange(of: viewModel.date, perform: { newDate in
                        if newDate > Date() {
                            viewModel.date = Date()
                        }
                    })
                
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 60)
                        .foregroundColor(Color.gray50)
                        .cornerRadius(12)
                    Button {
                        showCalendarModal = false
                    } label: {
                        Text("확인")
                            .foregroundColor(.primaryGB)
                            .bold()
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    struct DateSelectionView: View {
        @ObservedObject var viewModel: UpdateItemViewModel
        @Binding var showCalendarModal: Bool
        @Binding var name: String
        @Binding var price: Int
        
        var body: some View {
            HStack(spacing: 24) {
                Button(action: {
                    viewModel.decreaseDate = viewModel.date
                    viewModel.addNewItemBlock(name: name, price: price)
                }, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 8, height: 14)
                })
                
                Button(action: {
//                    viewModel.isDatePickerOpen.toggle()
                    showCalendarModal = true
                }, label: {
                    Text("\(viewModel.dateString)")
                        .font(.pretendard(.bold, size: 20))
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
    
    
    func addItemBlockView(name: String, price: Int) {
        viewModel.addNewItemBlock(name: name, price: price)
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


struct OCRUpdateItemView_Previews: PreviewProvider {
    @State var testDict = ["상품명":[], "단가":[], "수량":[], "금액":[]]
    static var previews: some View {
        OCRUpdateItemView(viewModel: UpdateItemViewModel(), gptAnswer: .constant(["test": []]), appState: AppState(), itemBlockName: "", itemBlockPrice: 0, dateText: Date())
    }
}
