//
//  ItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

enum selected{
    case basic
    case fastEat
    case slowEat
    case unselected
}

struct ItemDetailView: View {
    var greenBlueGradient = Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")])
    var notSelectedGradient = Gradient(colors: [Color("Gray200"), Color("Gray200")])
    var clearGradient = Gradient(colors: [.clear, .clear])
    
    @State var needToEatASAP: selected = .unselected
    @State private var isShowingEditView = false
    
    var body: some View {
        
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10.adjusted, height: 18.adjusted)
                    Spacer()
                    Text("계란 30구")
                        .bold()
                        .padding(.leading, 15.adjusted)
                    Spacer()
                    Button(action: {
                        self.isShowingEditView.toggle()
                    }, label: {
                        Text("수정")
                            .bold()
                            .foregroundColor(.black)
                    })
                    .fullScreenCover(isPresented: $isShowingEditView) {
                        EditItemDetailView(isShowingEditView: $isShowingEditView)
                    }
                }
                .padding(.top, 10)
                
                ScrollView {
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            
                            HStack {
                                Circle()
                                    .foregroundColor(Color("Gray200"))
                                    .frame(width: 80)
                                Text("계란 30구")
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(.leading, 15)
                            }
                            .padding(.vertical, 30)
                            
                            Text("구매일")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("Gray600"))
                                .padding(.bottom, 12)
                            Text("2023년 7월 39일")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.bottom, 30)
                            
                            Text("구매금액")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color("Gray600"))
                                .padding(.bottom, 12)
                            Text("9,800원")
                                .font(.system(size: 20, weight: .bold))
                                .padding(.bottom, 30)
                        }
                        
                        Spacer()
                    }
                    .padding(.leading, 20.adjusted)
                    
                    Rectangle()
                        .frame(width: screenWidth ,height: 12)
                        .foregroundColor(Color("Gray100"))
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    // 식재료 정보와 냉장고 선택창과의 분리
                    
                    VStack(alignment: .leading) {
                        Text("냉장고 선택하기")
                            .bold()
                            .font(.title2)
                        Text("식료품의 특징에 맞게 선택해주세요.")
                            .font(.subheadline)
                            .padding(.top, 1)
                        Text("일반")
                            .bold()
                            .padding(.vertical, 5)
                        VStack {
                            Button(action: {
                                needToEatASAP = .basic
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
                                                        gradient: needToEatASAP == .basic ? greenBlueGradient: notSelectedGradient,
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    ),
                                                    lineWidth: 2
                                                )
                                                .frame(width: 20, height: 20)
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        gradient: needToEatASAP == .basic ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .frame(width: 8, height: 8)
                                        }
                                        .padding(.leading, 20)
                                        
                                        Text("기본")
                                            .font(.system(size: 17, weight: .semibold))
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
                                            gradient: needToEatASAP == .basic ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            
                            Button(action: {needToEatASAP = .fastEat}) {
                                Text(" ")
                                    .frame(width: 10.adjusted, height: 10.adjusted)
                                    .background(needToEatASAP == .fastEat ? greenBlueGradient : clearGradient)
                                    .cornerRadius(100)
                                    .padding(7)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(LinearGradient(
                                            gradient: needToEatASAP == .fastEat ? greenBlueGradient : notSelectedGradient,
                                            startPoint: .leading,
                                            endPoint: .trailing), lineWidth: 3)
                                    )
                                Text("빨리 먹어야 해요")
                                    .padding(.leading, 5.adjusted)
                                    .foregroundColor(Color("Gray900"))
                            }
                            .padding(.horizontal, 20)
                            .frame(width: 350.adjusted, height: 60.adjusted, alignment: .leading)
                            .background(Color("Gray50"))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(
                                    gradient: needToEatASAP == .fastEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ), lineWidth: 3)
                                     
                            )
                        }
                        Text("장기 보관")
                            .bold()
                            .padding(.vertical, 5)
                        VStack {
                            Button(action: {needToEatASAP = .slowEat}) {
                                Text(" ")
                                    .frame(width: 10.adjusted, height: 10.adjusted)
                                    .background(needToEatASAP == .slowEat ? greenBlueGradient : clearGradient)
                                    .cornerRadius(100)
                                    .padding(7)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(LinearGradient(
                                            gradient: needToEatASAP == .slowEat ? greenBlueGradient : notSelectedGradient,
                                            startPoint: .leading,
                                            endPoint: .trailing), lineWidth: 3)
                                    )
                                Text("천천히 먹어도 돼요")
                                    .padding(.leading, 5.adjusted)
                                    .foregroundColor(Color("Gray900"))
                            }
                            .padding(.horizontal, 20)
                            .frame(width: 350.adjusted, height: 60.adjusted, alignment: .leading)
                            .background(Color("Gray50"))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(
                                    gradient:needToEatASAP == .slowEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ), lineWidth: 3)
                                     
                            )
                        }
                    }
                    .frame(width: 350.adjusted, alignment: .leading)
                    Spacer()
                }
            } // first VStack
            .padding(.horizontal, 20.adjusted)
        
        }
        
    struct ItemDetailView_Previews: PreviewProvider {
        static var previews: some View {
            ItemDetailView()
        }
    }
}
