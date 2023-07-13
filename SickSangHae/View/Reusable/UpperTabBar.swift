//
//  UpperTabBar.swift
//  SickSangHae
//
//  Created by Narin Kang on 2023/07/13.
//

import SwiftUI

struct UpperTabBar: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.06)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0, green: 0.83, blue: 0.65), location: 0.00),
                            Gradient.Stop(color: Color(red: 0, green: 0.58, blue: 1), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.09, y: 0),
                        endPoint: UnitPoint(x: 1.34, y: 3.1)
                    )
                )
                .cornerRadius(15, corners: [.topLeft, .topRight])


            HStack{
                Image(systemName: "barcode.viewfinder")
                Text("바코드 스캔하기")
            }
            .bold()
            .foregroundColor(.white)

        }
        .padding(.bottom, 30)
    }
}

struct UpperTabBar_Previews: PreviewProvider {
    static var previews: some View {
        UpperTabBar()
    }
}
