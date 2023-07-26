//
//  SmallButtonView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct SmallButtonView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                Divider()
                    .foregroundColor(Color("Gray100"))
                    .frame(width: 390.adjusted, height: 1.adjusted)
                HStack {
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 0)
                                .background(Color("PrimaryG"))
                                .cornerRadius(15)
                            Text("먹었어요😋")
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    Spacer()
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 0)
                                .background(Color("SmallButton"))
                                .cornerRadius(15)
                            Text("상했어요🤢")
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                .padding(EdgeInsets(top: 20.adjusted, leading: 20.adjusted, bottom: 20.adjusted, trailing: 20.adjusted))
                // Figma 화면과 비슷한 배율로 그리려면 top padding 15로 해야함
            }
        }
    }
    
    struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .fontWeight(.heavy)
                .frame(width: 167.adjusted, height: 60.adjusted)
                .foregroundColor(.white)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    
    struct SmallButtonView_Previews: PreviewProvider {
        static var previews: some View {
            SmallButtonView()
        }
    }
}
