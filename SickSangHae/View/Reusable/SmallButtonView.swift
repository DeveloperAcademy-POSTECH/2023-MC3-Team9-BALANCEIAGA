//
//  SmallButtonView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct SmallButtonView: View {
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    let receipt: Receipt
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack(spacing: 0){
                HStack {
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeOut(duration: 0.5)) {
                            coreDataViewModel.updateStatus(target: receipt, to: .Eaten)
                            }
                        }
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 0)
                                .background(Color("PrimaryG"))
                                .cornerRadius(16)
                            Text("먹었어요😋")
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeOut(duration: 0.5)) {
                            coreDataViewModel.updateStatus(target: receipt, to: .Spoiled)
                            }
                        }
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .stroke(lineWidth: 0)
                                .background(Color("SmallButton"))
                                .cornerRadius(16)
                            Text("상했어요🤢")
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            }
        }
    }
    
    struct CustomButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .fontWeight(.heavy)
                .frame(width: 167.adjusted, height: 55)
                .foregroundColor(.white)
                .opacity(configuration.isPressed ? 0.7 : 1)
        }
    }
    
    
    struct SmallButtonView_Previews: PreviewProvider {
        static let coreDataViewModel = CoreDataViewModel()
        static var previews: some View {
            SmallButtonView(receipt: Receipt(context: coreDataViewModel.viewContext))
                .environmentObject(coreDataViewModel)
        }
    }
}
