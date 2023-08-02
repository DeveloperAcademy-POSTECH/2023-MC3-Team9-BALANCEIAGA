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
                ScrollView {
                    itemInfoSection
                    
                    SmallButtonView(receipt: receipt)
                    
                    Rectangle()
                        .frame(width: screenWidth ,height: 12)
                        .foregroundColor(Color("Gray100"))
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    
                    
                    
                    VStack(alignment: .leading) {
                        Text("냉장고")
                            .font(.system(size: 17, weight: .bold))
                            .padding(.bottom, 5)
                        
                        radioButtonGroup
                            .disabled(isShowingTopAlertView)
                        
                        Text("식료품 정보")
                            .font(.system(size: 17, weight: .bold))
                            .padding(.vertical, 5)
                        
                        itemInfoView
                    } //VStack닫기
                    .padding(.horizontal, 20.adjusted)
                    .padding(.bottom, 40)
                }
            } // VStack닫기
            .padding(.top, 40)
            
            VStack {
                topNaviBar(dismiss: dismiss)
                Spacer()
            }
                
                
                VStack {
                    if isShowingTopAlertView {
                        itemDetailTopAlertView
                            .padding(.vertical, 30)
                    }
                    Spacer()
                }
                CenterAlertView(titleMessage: "식료품 삭제", bodyMessage: receipt.name, actionButtonMessage: "삭제", isShowingCenterAlertView: $isShowingCenterAlertView, isDeletingItem: $isDeletingItem)
                    .opacity(isShowingCenterAlertView ? 1 : 0)
                    .onChange(of: isDeletingItem) { _ in
                        if isDeletingItem {
                            dismiss()
                            coreDataViewModel.deleteReceiptData(target: receipt)
                        }
                    }
                    .onAppear {
                        
                    }
                    .onDisappear {
                        isDeletingItem = false
                    }
        }
        .navigationBarHidden(true)
    } //body닫기
        
    func topNaviBar(dismiss: DismissAction) -> some View {
        HStack {
            Button {
                dismiss()
            } label: {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 36, height: 36)
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 18)
                        .foregroundColor(Color.gray600)
                }
            }

            Spacer()
//                .background(.clear)

            menuButton
            .fullScreenCover(isPresented: $isShowingEditView) {
                EditItemDetailView(isShowingEditView: $isShowingEditView, iconText: receipt.icon, nameText: receipt.name, dateText: receipt.dateOfPurchase, wonText: "\(receipt.price)", appState: appState, receipt: receipt)
            }
        } //HStack닫기
        .padding(.top, 30)
        .padding(.horizontal, 20)
    }
        
    var itemInfoSection: some View {
        VStack(spacing: 0) {
            Image(receipt.icon)
                .resizable()
                .foregroundColor(Color("Gray200"))
                .frame(width: 80, height: 80)
                .padding(.vertical, 30)
            
            Text("\(receipt.name)")
                .font(.system(size: 22, weight: .bold))
        }
        .padding(.horizontal, 20.adjusted)
    }
    
    var radioButtonGroup: some View {
        Group {
            bacicRadioButton
            fastEatRadioButton
            slowEatRadioButton
        }
        .disabled(isShowingTopAlertView)
    }
    
    var bacicRadioButton: some View {
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
            Rectangle()
                .frame(width: 36, height: 36)
                .foregroundColor(.clear)
                .overlay(
                    Image(systemName: "ellipsis")
                        .resizable()
                        .foregroundColor(Color.gray600)
                        .frame(width: 21, height: 5)
                )
        } //Menu닫기
    }
    
    
    var itemInfoView: some View {
        ZStack(alignment: .trailing) {
                Rectangle()
                    .foregroundColor(.lightGrayColor)
                    .cornerRadius(12)
                
                VStack(alignment: .leading) {
                    HStack(spacing: 28) {
                        Text("품목")
                            .padding(.leading,20)
                        
                        Text(receipt.name)
                        
                    }
                    Divider().foregroundColor(.gray100)
                    HStack(spacing: 28) {
                        Text("금액")
                            .padding(.leading,20)
                        
                        Text("\(Int(receipt.price))")
                        
                    }
                    Spacer().frame(height: 10)
                }
                .frame(height: 116.adjusted)
        }
    }
    
    var itemDetailTopAlertView: some View {
        Group {
            TopAlertView(viewModel: topAlertViewModel)
                .transition(.move(edge: .top))
        }
        .opacity(isShowingTopAlertView ? 1 : 0)
//        .animation(.easeInOut(duration: 0.4))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                withAnimation(.easeInOut(duration: 0.5)) {
                    isShowingTopAlertView = false
//                }
            }
        }
    }
}

struct ItemDetailTopAlertView: View {
    let name: String
    var body: some View {
        ItemDetailTopAlertBaseView(iconImage: "img_eat", message: "\(name) 항목이 일반으로 이동됐어요", backgroundColor: .pointRLight, strokeColor: .pointRMiddle)
    }
}

struct ItemDetailTopAlertBaseView: View {
  var iconImage: String
  var message: String
  var backgroundColor: Color
  var strokeColor: Color
  @GestureState private var dragOffset = CGSize.zero
  

  var body: some View {
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 41.adjusted)
          .stroke(strokeColor, lineWidth: 1)
          .background(backgroundColor)
          .background(.ultraThickMaterial)
          .frame(height: 68.adjusted)
          .clipShape(RoundedRectangle(cornerRadius: 41.adjusted))
          .opacity(0.8)
        HStack(spacing: 10.adjusted) {
          Image(iconImage)
            .resizable()
            .scaledToFill()
            .frame(width: 44.adjusted, height: 44.adjusted)
          VStack(alignment: .leading, spacing: 4.adjusted) {
            Text(message)
              .font(.system(size: 14).bold())
              .foregroundColor(.black)
          }
        }
        .padding(.leading, 14.adjusted)
      }
      .padding([.leading, .trailing], 20.adjusted)
  }
}

extension ItemDetailTopAlertView: Hashable {
    func hash(into hasher: inout Hasher) {
        
    }
}
        
struct ItemDetailView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        ItemDetailView(topAlertViewModel: TopAlertViewModel(name: "파채", changedStatus: .shortTermPinned), receipt: Receipt(context: coreDataViewModel.viewContext), appState: AppState(), needToEatASAP: .shortTermUnEaten)
            .environmentObject(coreDataViewModel)
    }
}
