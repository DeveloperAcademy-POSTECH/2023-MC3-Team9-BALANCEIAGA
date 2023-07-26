//
//  EditItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}

struct EditItemDetailView: View {
    
    @Binding var isShowingEditView: Bool
    
    @State private var isShowingIconView = false
    
    @State var nameText: String = ""
    @State var dateText: String = ""
    @State var wonText: String = ""
    
    var body: some View {
        VStack {
            topNaviBar
            ScrollView {
                iconEdit
                InfoEditField(nameText: $nameText, wonText: $wonText)
            }
            deleteButton
        }
        .padding(.horizontal, 20.adjusted)
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            self.endTextEditing()
        }
    }
    
    var topNaviBar: some View {
        ZStack {
            Text("수정")
                .bold()
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
                    self.isShowingEditView.toggle()
                }, label: {
                    Text("완료")
                        .bold()
                })
                .disabled(nameText.isEmpty)
                .disabled(nameText == nameText && dateText == dateText && wonText == wonText)
            }
        }
        .padding(.top, 10)
    }
    
    var iconEdit: some View {
        ZStack(alignment: .bottomTrailing) {
            //추후 Custom Item Icon으로 대체
            Circle()
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
                EditIconDetailView()
            }
        }
        .padding(.vertical, 20.adjusted)
    }
    
    var deleteButton: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                Rectangle()
                    .cornerRadius(8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray100"))
                Text("항목 삭제")
                    .bold()
                    .foregroundColor(.red)
            }
            .padding(.bottom, 20.adjusted)
        })
    }
}


struct InfoEditField: View {
    
    @Binding var nameText: String
    @Binding var wonText: String
    
    @State private var isEditing = false
    @FocusState var isInputActive: Bool
    
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false
    
    var body: some View {
        nameField
        dateField
        wonField
    }
    
    var nameField: some View {
        VStack(alignment: .leading) {
            Text("품목명")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("Gray600"))
            
            ZStack(alignment: .leading) {
                if nameText.isEmpty {
                    Text("품목명은 필수에요")
                        .bold()
                        .foregroundColor(Color("Gray200"))
                } else {
                    EmptyView()
                }
                
                TextField("", text: $nameText)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("완료") {
                                isInputActive = true
                            }
                        }
                    }
                
                if nameText.isEmpty || !isInputActive {
                    EmptyView()
                } else {
                    Button(action: {
                        self.nameText = ""
                    }, label: {
                        HStack {
                            Spacer()
                            
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
                .font(.system(size: 14, weight: .medium))
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
                    DatePicker("구매일자", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .presentationDetents([.medium])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.horizontal, 10)
                        .environment(\.locale, .init(identifier: "ko"))
                        .onChange(of: selectedDate) { _ in
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
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color("Gray600"))
            
            ZStack(alignment: .leading) {
                if wonText.isEmpty {
                    Text("얼마였나요?")
                        .bold()
                        .foregroundColor(Color("Gray200"))
                } else {
                    EmptyView()
                }
                
                TextField("", text: $wonText)
                    .focused($isInputActive)
                    .keyboardType(.numberPad)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("완료") {
                                isInputActive = false
                            }
                        }
                    }
                
                if wonText.isEmpty || !isInputActive {
                    EmptyView()
                } else {
                    Button(action: {
                        self.wonText = ""
                    }, label: {
                        HStack {
                            Spacer()
                            
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
        return formatter.string(from: selectedDate)
    }
}

struct EditItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditItemDetailView(isShowingEditView: .constant(false))
    }
}
