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
                    .frame(width: 10.adjusted, height: 18.adjusted)
                Spacer()
                Text("계란 30구")
                    .bold()
                    .padding(.leading, 15.adjusted)
                Spacer()
                Text("수정")
                    .bold()
            }
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
                
                Text("장기 보관")
                    .bold()
                    .padding(.vertical, 5)
            }
            .frame(width: 350.adjusted, alignment: .leading)
            Spacer()
        }
        .padding(.horizontal, 20.adjusted)
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
