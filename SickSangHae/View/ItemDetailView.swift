//
//  ItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

//enum selected{
//    case basic
//    case fastEat
//    case slowEat
//    case unselected
//}

struct ItemDetailView: View {
    var greenBlueGradient = Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")])
    var notSelectedGradient = Gradient(colors: [Color("Gray200"), Color("Gray200")])
    var clearGradient = Gradient(colors: [.clear, .clear])
    
    @State var appState: AppState
    
    @State private var isShowingEditView = false
    
    @State var receipt: Receipt
    
    @EnvironmentObject var coreDateViewModel: CoreDataViewModel
    
    //    @State var needToEatASAP: selected = .unselected
        @State var needToEatASAP: Status {
            didSet {
                coreDateViewModel.updateStatus(target: receipt, to: needToEatASAP)
            }
        }
    
    init(receipt: Receipt, appState: AppState) {
        self.receipt = receipt
        self.needToEatASAP = receipt.currentStatus
        self.appState = appState
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            topNaviBar
            
            ScrollView {
                itemInfoSection
                
                VStack(alignment: .leading) {
                    Text("냉장고 선택하기")
                        .font(.pretendard(.bold, size: 20))
                        .font(.title2)
                        .padding(.bottom, 2)
                    
                    Text("식료품의 특징에 맞게 선택해주세요.")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundColor(Color("Gray600"))
                    
                    Text("일반")
                        .font(.pretendard(.bold, size: 17))
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    bacicRadioButton
                    
                    fastEatRadioButton
                    
                    Text("장기 보관")
                        .font(.pretendard(.bold, size: 17))
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    slowEatRadioButton
                    
                    Spacer()
                    
                } //VStack닫기
                .padding(.horizontal, 20.adjusted)
                .padding(.bottom, 40)
            } //ScrollView닫기
            SmallButtonView(receipt: receipt)
        } // VStack닫기
    } //body닫기
        
    var topNaviBar: some View {
        HStack {
            Button {
                print("clicked")
                appState.moveToRootView = true
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 18)
            }
            Spacer()
            
            Text("\(receipt.name)")
                .bold()
                .padding(.leading, 15)
            
            Spacer()
            
            Button(action: {
                self.isShowingEditView.toggle()
            }, label: {
                Text("수정")
                    .bold()
                    .foregroundColor(.black)
            })
            .fullScreenCover(isPresented: $isShowingEditView) {
                EditItemDetailView(isShowingEditView: $isShowingEditView, iconText: receipt.icon, nameText: receipt.name, dateText: receipt.dateOfPurchase, wonText: "\(receipt.price)", appState: appState, receipt: receipt)
            }
        } //HStack닫기
        .padding(.top, 10)
        .padding(.horizontal, 20.adjusted)
    }
        
    var itemInfoSection: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack {
                        Image(receipt.icon)
                            .resizable()
                            .foregroundColor(Color("Gray200"))
                            .frame(width: 80, height: 80)
                        
                        Text("\(receipt.name)")
                            .font(.pretendard(.bold, size: 22))
                            .padding(.leading, 15)
                    }
                    .padding(.vertical, 30)
                    
                    Text("구매일")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundColor(Color("Gray600"))
                        .padding(.bottom, 12)
                    
                    Text("\(receipt.dateOfPurchase.formattedDate)")
                        .font(.pretendard(.bold, size: 20))
                        .padding(.bottom, 30)
                    
                    Text("구매금액")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundColor(Color("Gray600"))
                        .padding(.bottom, 12)
                    
                    Text("\(Int(receipt.price))원")
                        .font(.pretendard(.bold, size: 20))
                        .padding(.bottom, 30)
                }
                
                Spacer()
            } //HStack닫기
            .padding(.leading, 20.adjusted)
            
            Rectangle()
                .frame(width: screenWidth ,height: 12)
                .foregroundColor(Color("Gray100"))
                .padding(.top, 10)
                .padding(.bottom, 30)
        }
        
    }
    
    var bacicRadioButton: some View {
        Button(action: {
//            needToEatASAP = .basic
            needToEatASAP = .shortTermUnEaten
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
//                            .stroke(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .basic ? greenBlueGradient: notSelectedGradient,
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                ),
//                                lineWidth: 2
//                            )
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
//                            .fill(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .basic ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
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
//                .stroke(
//                    LinearGradient(
//                        gradient: needToEatASAP == .basic ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    ),
//                    lineWidth: 2
//                )
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
//            needToEatASAP = .fastEat
            needToEatASAP = .shortTermPinned
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
//                            .stroke(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .fastEat ? greenBlueGradient: notSelectedGradient,
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                ),
//                                lineWidth: 2
//                            )
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
//                            .fill(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .fastEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
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
//                .stroke(
//                    LinearGradient(
//                        gradient: needToEatASAP == .fastEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    ),
//                    lineWidth: 2
//                )
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
//            needToEatASAP = .slowEat
            needToEatASAP = .longTermUnEaten
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 60)
                    .foregroundColor(Color("Gray50"))
                
                HStack {
                    ZStack {
                        Circle()
//                            .stroke(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .slowEat ? greenBlueGradient: notSelectedGradient,
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                ),
//                                lineWidth: 2
//                            )
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
//                            .fill(
//                                LinearGradient(
//                                    gradient: needToEatASAP == .slowEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
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
//                .stroke(
//                    LinearGradient(
//                        gradient: needToEatASAP == .slowEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    ),
//                    lineWidth: 2
//                )
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
}
        
struct ItemDetailView_Previews: PreviewProvider {
    static let coreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        ItemDetailView(receipt: Receipt(context: coreDataViewModel.viewContext), appState: AppState())
    }
}
