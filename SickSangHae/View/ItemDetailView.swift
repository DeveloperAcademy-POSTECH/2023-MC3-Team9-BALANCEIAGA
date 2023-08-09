//
//  ItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @ObservedObject var topAlertViewModel: TopAlertViewModel
    
    @State private var isShowingEditView = false
    @State private var isShowingTopAlertView = false
    @State private var isShowingCenterAlertView = false
    @State private var isDeletingItem = false
    @State private var timer: Timer? = nil
    @State var receipt: Receipt
    @State var appState: AppState
    @State var needToEatASAP: Status {
        didSet {
            topAlertViewModel.changedStatus = needToEatASAP
            withAnimation(.easeInOut(duration: 0.5)) {
                isShowingTopAlertView = true
            }
            coreDataViewModel.updateStatus(target: receipt, to: needToEatASAP)
        }
    }

    
    var greenBlueGradient = Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")])
    var notSelectedGradient = Gradient(colors: [Color("Gray200"), Color("Gray200")])
    var clearGradient = Gradient(colors: [.clear, .clear])
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topNaviBar(dismiss: dismiss)
                
                ScrollView {
                    topItemInfoSection
                    
                    SmallButtonView(receipt: receipt)
                    
                    Rectangle()
                        .frame(width: screenWidth ,height: 12)
                        .foregroundColor(Color("Gray100"))
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading) {
                        Text("냉장고")
                            .font(.pretendard(.semiBold, size: 17))
                            .foregroundColor(.gray800)
                            .padding(.bottom, 5)
                        
                        radioButtonGroup
                            .disabled(isShowingTopAlertView)
                            .padding(.bottom, 10)
                        
                        Text("식료품 정보")
                            .font(.pretendard(.semiBold, size: 17))
                            .foregroundColor(.gray800)
                            .padding(.bottom, 5)
                        
                        bottomItemInfoSection
                    } //VStack닫기
                    .padding(.horizontal, 20.adjusted)
                    .padding(.bottom, 40)
                } // ScrollView닫기
            } // VStack닫기
            
            VStack {
                if isShowingTopAlertView {
                    itemDetailTopAlertView
                        .padding(.top, 50)
                }
                Spacer()
            }
            
            CenterAlertView(titleMessage: "식료품 삭제", bodyMessage: receipt.name, actionButtonMessage: "삭제", isShowingCenterAlertView: $isShowingCenterAlertView, isDeletingItem: $isDeletingItem)
                .opacity(isShowingCenterAlertView ? 1 : 0)
                .onChange(of: isDeletingItem) { _ in
                    if isDeletingItem {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                coreDataViewModel.deleteReceiptData(target: receipt)
                            }
                        }
                    }
                } // onChange닫기
                .onDisappear {
                    isDeletingItem = false
                } // onDisappear닫기
        } // ZStack닫기
        .navigationBarHidden(true)
        
        
    } //body닫기
        
    private func topNaviBar(dismiss: DismissAction) -> some View {
        HStack {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 44, height: 44)
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 12, height: 21)
                        .foregroundColor(Color("PrimaryGB"))
                }
            }

            Spacer()

            menuButton
            .fullScreenCover(isPresented: $isShowingEditView) {
                EditItemDetailView(isShowingEditView: $isShowingEditView, iconText: receipt.icon, nameText: receipt.name, dateText: receipt.dateOfPurchase, wonText: "\(Int(receipt.price))", appState: appState, receipt: receipt)
            }
        } //HStack닫기
        .padding(.top, 10)
        .padding(.horizontal, 10)
    }
    
    private func showTopAlert(duration: TimeInterval) {
        isShowingTopAlertView = true

        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            isShowingTopAlertView = false
        }
    }

    var itemDetailTopAlertView: some View {
        TopAlertView(viewModel: topAlertViewModel)
            .opacity(isShowingTopAlertView ? 1 : 0)
            .onAppear {
                showTopAlert(duration: 1.5)
            }
    }
    
    var menuButton: some View {
        Menu {
            Button(action: {
                isShowingEditView = true
            }, label: {
                Text("편집")
                Image(systemName: "pencil")
            })
            
            Divider()
            
            Button(role: .destructive, action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isShowingCenterAlertView = true
                }
            }, label: {
                Text("삭제")
                Image(systemName: "trash.fill")
            })
        } label: {
            ZStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 44, height: 44)
                Image(systemName: "ellipsis")
                    .resizable()
                    .foregroundColor(Color("PrimaryGB"))
                    .frame(width: 22, height: 5)
            }
        } //Menu닫기
    }
    
    var topItemInfoSection: some View {
        VStack(spacing: 0) {
            Image(receipt.icon)
                .resizable()
                .foregroundColor(Color("Gray200"))
                .frame(width: 110, height: 110)
                .padding(.vertical, 30)
            
            Text("\(receipt.name)")
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 20.adjusted)
    }
    
    var radioButtonGroup: some View {
        Group {
            basicRadioButton
            fastEatRadioButton
            slowEatRadioButton
        }
    }
    
    var basicRadioButton: some View {
        Button(action: {
            needToEatASAP = .shortTermUnEaten
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: needToEatASAP == .shortTermUnEaten ? greenBlueGradient: notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: needToEatASAP == .shortTermUnEaten ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    .padding(.leading, 20)
                    
                    Text("기본")
                        .font(.pretendard(.semiBold, size: 17))
                        .padding(.leading, 5)
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                }
            }
        })
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    LinearGradient(
                        gradient: needToEatASAP == .shortTermUnEaten ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
        )
        
    }
    
    var fastEatRadioButton: some View {
        Button(action: {
            needToEatASAP = .shortTermPinned
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: needToEatASAP == .shortTermPinned ? greenBlueGradient: notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: needToEatASAP == .shortTermPinned ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    .padding(.leading, 20)
                    
                    Text("빨리 먹어야 해요")
                        .font(.pretendard(.semiBold, size: 17))
                        .padding(.leading, 5)
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                }
            }
        })
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    LinearGradient(
                        gradient: needToEatASAP == .shortTermPinned ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
        )
    }
    
    var slowEatRadioButton: some View {
        Button(action: {
            needToEatASAP = .longTermUnEaten
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    gradient: needToEatASAP == .longTermUnEaten ? greenBlueGradient: notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: needToEatASAP == .longTermUnEaten ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    .padding(.leading, 20)
                    
                    Text("천천히 먹어도 돼요")
                        .font(.pretendard(.semiBold, size: 17))
                        .padding(.leading, 5)
                        .foregroundColor(Color("Gray900"))
                    
                    Spacer()
                }
            }
        })
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    LinearGradient(
                        gradient: needToEatASAP == .longTermUnEaten ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
        )
    }
    
    var bottomItemInfoSection: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .foregroundColor(.gray50)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 28) {
                    Text("구매일자")
                        .font(.pretendard(.medium, size: 17))
                        .foregroundColor(.gray600)
                        .padding(.leading,20)
                    
                    Text("\(receipt.dateOfPurchase.formattedDate)")
                        .font(.pretendard(.semiBold, size: 17))
                    
                }
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray100)
                    .padding(.leading, 20)
                    .padding(.vertical, 16)
                
                HStack(spacing: 28) {
                    Text("구매금액")
                        .font(.pretendard(.medium, size: 17))
                        .foregroundColor(.gray600)
                        .padding(.leading,20)
                    
                    Text("\(Int(receipt.price))원")
                        .font(.pretendard(.semiBold, size: 17))
                    
                }
            }
            .frame(height: 116.adjusted)
        }
        .padding(.bottom, 30)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        ItemDetailView(topAlertViewModel: TopAlertViewModel(name: "파채", changedStatus: .shortTermPinned), receipt: Receipt(context: coreDataViewModel.viewContext), appState: AppState(), needToEatASAP: .shortTermUnEaten)
            .environmentObject(coreDataViewModel)
    }
}
