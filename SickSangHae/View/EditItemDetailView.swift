//
//  EditItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct EditItemDetailView: View {
    
    @Binding var isShowingEditView: Bool
    
    @State private var isShowingIconView = false
    
    @State var iconText: String
    @State var nameText: String
    @State var dateText: Date
    @State var wonText: String
    @State var appState: AppState
    
    @EnvironmentObject var coreDateViewModel: CoreDataViewModel
    
    let receipt: Receipt
    
    var body: some View {
        VStack {
            topNaviBar
            ScrollView {
                editIconButton
                InfoEditField(nameText: $nameText,dateText: $dateText, wonText: $wonText)
            }
        }
        .padding(.horizontal, 20.adjusted)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            endTextEditing()
        }
    }
    
    var topNaviBar: some View {
        ZStack {
            HStack {
                Button(action: {
                    self.isShowingEditView.toggle()
                }, label: {
                    Text("취소")
                        .bold()
                        .foregroundColor(.black)
                })
                Spacer()
                Button(action: {
                    //변경된 텍스트 값을 ItemDetailView로 업데이트하는 로직
                    coreDateViewModel.editReceiptData(target: receipt,icon: iconText, name: nameText, dateOfPurchase: dateText, price: wonText)
                    self.isShowingEditView.toggle()
                }, label: {
                    Text("완료")
                        .bold()
                })
                .disabled(nameText.isEmpty)
                // 추후 CoreData연결하면서 품목명, 구매일, 구매금액, 아이콘 넷 중 하나라도 바뀌지 않는다면 완료버튼이 비활성화 되도록 disabled조건문 추가
            }
        }
        .padding(.top, 10)
    }
    
    var editIconButton: some View {
        ZStack(alignment: .bottomTrailing) {
            //추후 Custom Item Icon으로 대체
            Image(iconText)
                .resizable()
                .foregroundColor(Color("Gray200"))
                .frame(width: 110, height: 110)
            
            Button(action: {
                self.isShowingIconView.toggle()
            }, label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color("Gray100"))
                        .frame(width: 28, height: 28)
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .frame(width: 28, height: 28)
                        .overlay(
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        )
                }
            })
            .sheet(isPresented: self.$isShowingIconView) {
                EditIconDetailView(receiptIcon: $iconText, currentIcon: receipt.icon)
            }
        }
        .padding(.vertical, 20.adjusted)
    }
    
    
    func moveToRootViewAndDelete(completion: () -> ()) {
        isShowingEditView = false
        appState.moveToRootView = true
        completion()
    }
}


struct InfoEditField: View {
    
    @Binding var nameText: String
    @Binding var dateText: Date
    @Binding var wonText: String
    
    @State private var isEditing = false
    @State private var showingDatePicker = false
    
    @FocusState var isNameInputActive: Bool
    @FocusState var isPriceInputActive: Bool
    
    var body: some View {
        nameField
        
        dateField
        
        wonField
    }
    
    var nameField: some View {
        VStack(alignment: .leading) {
            Text("품목명")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
            
            HStack {
                TextField("", text: $nameText, prompt: Text("품목명은 필수에요"))
                    .focused($isNameInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button("완료") {
                                isNameInputActive = true
                            }
                        }
                    }
                
                if !nameText.isEmpty && isNameInputActive {
                    Button(action: {
                        self.nameText = ""
                    }, label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("Gray200"))
                        }
                    })
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color("Gray50"))
            .cornerRadius(8)
        }
        .padding(.bottom, 10)
    }
    
    var dateField: some View {
        VStack(alignment: .leading) {
            Text("구매일")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
            
            ZStack(alignment: .leading) {
                Button(action: {
                    showingDatePicker.toggle()
                }, label: {
                    HStack {
                        Text(formattedDate)
                            .bold()
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                })
                .sheet(isPresented: $showingDatePicker) {
                    DatePicker("구매일자", selection: $dateText, in: ...Date(), displayedComponents: .date)
                        .presentationDetents([.medium])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.horizontal, 10)
                        .environment(\.locale, .init(identifier: "ko"))
                        .onChange(of: dateText) { _ in
                            showingDatePicker = false
                        }
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color("Gray50"))
            .cornerRadius(8)
        }
        .padding(.bottom, 10)
    }
    
    var wonField: some View {
        VStack(alignment: .leading) {
            Text("구매금액")
                .font(.pretendard(.medium, size: 14))
                .foregroundColor(Color("Gray600"))
            
            HStack {
                TextField("", text: $wonText, prompt: Text("얼마였나요?"))
                    .focused($isPriceInputActive)
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("완료") {
                                isPriceInputActive = false
                            }
                        }
                    }
                
                if !wonText.isEmpty && isPriceInputActive {
                    Button(action: {
                        self.wonText = ""
                    }, label: {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color("Gray200"))
                        }
                    })
                }
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(Color("Gray50"))
            .cornerRadius(8)
        }
        .padding(.bottom, 10)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: dateText)
    }
}

struct EditItemDetailView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        EditItemDetailView(isShowingEditView: .constant(false), iconText: "bread" ,nameText: "TestName", dateText: Date.now, wonText: "6000",appState: AppState(), receipt: Receipt(context: coreDataViewModel.viewContext))
    }
}
