//
//  ItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct ItemDetailView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: screenWidth * 0.03, height: screenHeight * 0.025)
                Spacer()
                Text("계란 30구")
                    .bold()
                    .padding(.leading, 15)
                Spacer()
                Text("수정")
                    .bold()
            }
            
            HStack {
                Circle()
                    .foregroundColor(.lightBlueGrayColor)
                    .frame(width: 100)
                Text("계란 30구")
                    .font(.title2)
                    .bold()
                    .padding(15)
            } //title
            .frame(width: screenWidth * 0.9, alignment: .leading)
            .padding(.vertical, 25)
            
            VStack(alignment: .leading) {
                Text("구매일")
                    .font(.subheadline)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .cornerRadius(15)
                        .frame(width: screenWidth * 0.9, height: screenHeight * 0.07)
                        .foregroundColor(.lightGrayColor)
                    Text("2023년 7월 39일")
                        .bold()
                        .padding(.horizontal, 20)
                }
                Text("구매금액")
                    .font(.subheadline)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .cornerRadius(15)
                        .frame(width: screenWidth * 0.9, height: screenHeight * 0.07)
                        .foregroundColor(.lightGrayColor)
                    Text("39,800원")
                        .bold()
                        .padding(.horizontal, 20.adjusted)
                }
            }
            
            Rectangle()
                .frame(width: screenWidth * 1, height: screenHeight * 0.015)
                .foregroundColor(.lightGrayColor)
                .padding(.vertical, 30)
            
            VStack(alignment: .leading) {
                Text("냉장고 선택하기")
                    .font(.title2)
                    .padding(.bottom, 10)
                Text("식료품의 특징에 맞게 선택해주세요.")
                    .font(.subheadline)
                Text("일반")
                    .bold()
                
                Spacer()
            }
            
        }
        .padding(.horizontal, 20)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
