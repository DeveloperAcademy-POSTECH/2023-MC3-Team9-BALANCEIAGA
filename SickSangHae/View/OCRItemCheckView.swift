//
//  ItemCheckView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct OCRItemCheckView: View {
    
    @Binding var gptAnswer: Dictionary<String, [Any]>
    // TODO: 나중에 뷰 연결할때는 @Binding으로 바꾸어야할 듯합니다.
    var isOCR = true
    @ObservedObject var viewModel = UpdateItemViewModel()
    @State var appState: AppState
    @State private var isRegisterCompleteView = false
    @State private var isShowingUpdateItemView = false
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        switch isOCR{
                        case true:
                            EmptyView()
                        default:
                            Image(systemName: "chevron.left")
                                .frame(width: 8, height: 14.2)
                        }
                        
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
                        .onTapGesture {
                            registerItemsToCoreData()
                        }
                    })
                }
            }
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isShowingUpdateItemView) {
                OCRUpdateItemView(viewModel: UpdateItemViewModel(),titleName: "수정", buttonName: "수정 완료",gptAnswer: $gptAnswer, appState: appState)
            }
        }
    }
    private var ListTitle: some View {
        HStack{
            Text(viewModel.dateString)
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted).weight(.bold))
            
            Spacer()
            
            switch isOCR{
            case true:
                Button {
                    isShowingUpdateItemView = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("Gray100"))
                        
                        Text("수정")
                            .foregroundColor(Color("Gray600"))
                            .font(.system(size: 14.adjusted))
                    }
                    .frame(width: 45, height: 25)
                    .foregroundColor(Color("Gray600"))
                    .padding(.trailing, 20.adjusted)
                }
            default:
                EmptyView()
            }
            
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

                ForEach(0..<gptAnswer["상품명"]!.count, id: \.self) { index in
                    let productName = gptAnswer["상품명"]![index] as! String
                    let quantity = gptAnswer["수량"]![index] as! Int
                    let price = gptAnswer["금액"]![index] as! Int

                    listDetail(listTraling: productName, listLeading: String(price), listColor: "Gray900")
                    
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
        for i in 0..<gptAnswer["상품명"]!.count {
            coreDataViewModel.createReceiptData(name: gptAnswer["상품명"]![i] as! String, price: Double(gptAnswer["금액"]![i] as! Int))
        }
    }
}

//struct ItemCheckView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ItemCheckView(gptAnswer: <#Binding<[String : [Any]]>#>, appState: <#AppState#>)
//    }
//}
