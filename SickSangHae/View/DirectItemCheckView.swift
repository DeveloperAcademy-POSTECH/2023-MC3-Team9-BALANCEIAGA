//
//  DirectItemCheckView.swift
//  SickSangHae
//
//  Created by user on 2023/07/30.
//


import SwiftUI

struct DirectItemCheckView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: UpdateItemViewModel
    @State var appState: AppState
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        Button(action:{dismiss()}, label: {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 10, height: 19)
                                .foregroundColor(.gray900)
                        })
                        
                        Spacer()
                        Button(action: {
                            self.appState.moveToRootView = true
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 15, height: 15)
                        })
                        .foregroundColor(.gray900)
                    }.padding(.horizontal, 20)
                    
                    HStack {
                        Text("아래 식료품을 등록할게요")
                            .fontWeight(.bold)
                            .padding(34)
                    }
                    
                    ListTitle
                    
                    ScrollView{
                        ListContents
                    }
                    
                    Spacer()
                    NavigationLink(destination: RegisterCompleteView(appState: appState) ,label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 350, height: 60)
                                .foregroundColor(Color("PrimaryGB"))
                                .cornerRadius(12)
                            HStack {
                                Text("등록하기")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                        .padding(.bottom, 30)
//                        .onTapGesture {
//                            registerItemsToCoreData()
//                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            registerItemsToCoreData()
                        })
                    })

                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    private var ListTitle: some View {
        HStack{
            Text(viewModel.dateString)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted).weight(.bold))
            
            Spacer()
            
            
        }
        .padding([.top, .bottom], 17.adjusted)
        .padding(.leading, 20.adjusted)
    }
    
    private var ListContents: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color("Gray50"))
                .padding(.horizontal, 20)
            
            VStack{
                
                listDetail(listTraling: "품목", listLeading: "금액", listColor: "Gray400")
                    .padding(.horizontal, 40)
                    .padding(.top)
                
                Divider()
                    .overlay(Color("Gray100"))

                ForEach(viewModel.itemBlockViewModels, id: \.self) { item in

                    listDetail(listTraling: item.name, listLeading: String(item.price), listColor: "Gray900")

                    Divider()
                        .overlay(Color("Gray100"))
                }
                .padding(.horizontal, 40.adjusted)
            }
        }
    }
    
    
    // TODO: listTraling에 품목을, listLeading에 금액을 넣어야 해요.
    private func listDetail(listTraling: String, listLeading: String, listColor: String) -> some View{
        return HStack{
            Text(listTraling)
                .foregroundColor(Color(listColor))
                .font(.system(size: 17.adjusted).weight(.semibold))
            
            Spacer()
            
            Text(listLeading)
                .foregroundColor(Color(listColor))
                .font(.system(size: 14.adjusted).weight(.semibold))
        }
        .padding([.top, .bottom], 8.adjusted)
    }
    
    
    func registerItemsToCoreData() {
        viewModel.itemBlockViewModels.forEach { item in
            coreDataViewModel.createReceiptData(name: item.name, price: Double(item.price))
        }
    }
}

struct DirectItemCheckView_Previews: PreviewProvider {

    static var previews: some View {
        DirectItemCheckView(viewModel: UpdateItemViewModel(),appState: AppState())
    }
}
