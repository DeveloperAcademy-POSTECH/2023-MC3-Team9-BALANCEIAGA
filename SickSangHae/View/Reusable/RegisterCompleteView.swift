//
//  RegisterCompleteView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct RegisterCompleteView: View {
    var body: some View {

        VStack(spacing: 35){
            Spacer()

            Circle()
                .frame(width: 140)
                .foregroundColor(Color("Gray100"))
            Text("등록이 완료되었어요")
                .font(.system(size: 18).weight(.semibold))

            Spacer()

            Button {
                // TODO: 여기에 닫기 버튼에 대한 기능을 완성해요
            } label:{
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 60)
                        .foregroundColor(.lightGreenGrayColor)
                        .cornerRadius(12)
                    HStack {
                        Text("닫기")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct RegisterCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterCompleteView()
    }
}
