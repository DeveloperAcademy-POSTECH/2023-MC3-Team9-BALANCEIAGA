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
            topNaviBar
            
            ScrollView {
                itemInfoSection
                
                VStack(alignment: .leading) {
                    Text("냉장고 선택하기")
                        .font(.system(size: 20, weight: .bold))
                        .font(.title2)
                        .padding(.bottom, 2)
                    
                    Text("식료품의 특징에 맞게 선택해주세요.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(Color("Gray600"))
                    
                    Text("일반")
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    bacicRadioButton
                    
                    fastEatRadioButton
                    
                    Text("장기 보관")
                        .font(.system(size: 17, weight: .bold))
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                    
                    slowEatRadioButton
                    
                    Spacer()
                    
                } //VStack닫기
                .padding(.horizontal, 20.adjusted)
                .padding(.bottom, 40)
            } //ScrollView닫기
        } // VStack닫기
    } //body닫기
        
    var topNaviBar: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .frame(width: 10, height: 18)
            
            Spacer()
            
            Text("계란 30구")
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
                EditItemDetailView(isShowingEditView: $isShowingEditView)
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
        
    }
    
    var fastEatRadioButton: some View {
        Button(action: {
            needToEatASAP = .fastEat
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
                                    gradient: needToEatASAP == .fastEat ? greenBlueGradient: notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: needToEatASAP == .fastEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    .padding(.leading, 20)
                    
                    Text("빨리 먹어야 해요")
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
                        gradient: needToEatASAP == .fastEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
        )
    }
    
    var slowEatRadioButton: some View {
        Button(action: {
            needToEatASAP = .slowEat
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
                                    gradient: needToEatASAP == .slowEat ? greenBlueGradient: notSelectedGradient,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                ),
                                lineWidth: 2
                            )
                            .frame(width: 20, height: 20)
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: needToEatASAP == .slowEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 8, height: 8)
                    }
                    .padding(.leading, 20)
                    
                    Text("천천히 먹어도 돼요")
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
                        gradient: needToEatASAP == .slowEat ? greenBlueGradient : Gradient(colors: [.clear, .clear]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 2
                )
        )
    }
}
        
struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
