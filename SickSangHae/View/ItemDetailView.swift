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
    
    
    var body: some View {
        
            VStack {
                ScrollView {
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10.adjusted, height: 18.adjusted)
                        Spacer()
                        Text("계란 30구")
                            .bold()
                            .padding(.leading, 15.adjusted)
                        Spacer()
                        Text("수정")
                            .bold()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Circle()
                            .foregroundColor(Color("Gray200"))
                            .frame(width: 80.adjusted)
                        Text("계란 30구")
                            .font(.title3)
                            .bold()
                            .padding(15)
                    }
                    .frame(width: 350.adjusted, alignment: .leading)
                    .padding(.vertical, 25.adjusted)
                    
                    VStack(alignment: .leading) {
                        Text("구매일")
                            .font(.subheadline)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .cornerRadius(8)
                                .frame(width: 350.adjusted, height: 60.adjusted)
                                .foregroundColor(Color("Gray50"))
                            Text("2023년 7월 39일")
                                .bold()
                                .padding(.horizontal, 20.adjusted)
                        }
                        Text("구매금액")
                            .font(.subheadline)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .cornerRadius(8)
                                .frame(width: 350.adjusted, height: 60.adjusted)
                                .foregroundColor(Color("Gray50"))
                            Text("9,800원")
                                .bold()
                                .padding(.horizontal, 20.adjusted)
                        }
                    }
                    Rectangle()
                        .frame(width: 390.adjusted ,height: 12.adjusted)
                        .foregroundColor(Color("Gray100"))
                        .padding(.vertical, 30.adjusted)
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
                            Button(action: {needToEatASAP = .basic}) {
                                Text(" ")
                                    .frame(width: 10.adjusted, height: 10.adjusted)
                                    .background(needToEatASAP == .basic ? greenBlueGradient : clearGradient)
                                    .cornerRadius(100)
                                    .padding(7)
                                    .overlay(RoundedRectangle(cornerRadius: 100)
                                        .stroke(LinearGradient(
                                            gradient: needToEatASAP == .basic ? greenBlueGradient: notSelectedGradient,
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ), lineWidth: 3)
                                    )
                                Text("기본")
                                    .padding(.leading, 5.adjusted)
                                    .foregroundColor(Color("Gray900"))
                            }
                            .padding(.horizontal, 20)
                            .frame(width: 350.adjusted, height: 60.adjusted, alignment: .leading)
                            .background(Color("Gray50"))
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(
                                    gradient: needToEatASAP == .basic ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ), lineWidth: 3)
                                     
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
