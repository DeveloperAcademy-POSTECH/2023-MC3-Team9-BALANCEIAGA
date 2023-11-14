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
    @ObservedObject var viewModel = UpdateItemViewModel()
    @State var appState: AppState
    @State private var isRegisterCompleteView = false
    @State private var isShowingUpdateItemView = false
    
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    ZStack(alignment: .top){
                        ZigZagShape()
                            .fill(Color.gray50)
                            .ignoresSafeArea()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 140)
                        VStack{
                            NavBar
                            
                            HStack {
                                Text("아래 식료품을 등록할게요")
                                    .foregroundColor(Color("Gray400"))
                                    .font(.pretendard(.semiBold, size: 20))
                                    .padding(34)
                            }
                        }
                        .padding(.top, 13)
                    }
                    
                    ListTitle
                    
                    ListContents
                    
                    Spacer()
                    
                    NavigationLink(isActive: $isRegisterCompleteView) {
                        RegisterCompleteView(appState: appState)
                    } label: {
                        EmptyView()
                    }
                    
                    Button {
                        registerItemsToCoreData()
                        isRegisterCompleteView = true
                    } label: {
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
                    }
                }
                .padding(.horizontal, 40)
            }
            .navigationBarBackButtonHidden(true)
            .fullScreenCover(isPresented: $isShowingUpdateItemView) {
                OCRUpdateItemView(viewModel: UpdateItemViewModel(),gptAnswer: $gptAnswer, appState: appState)
            }
        }
    }
    private var NavBar: some View{
        HStack {
//            Image(systemName: "chevron.left")
//                .frame(width: 8, height: 14.2)
            
            Spacer()
            
            Text("직접 추가")
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 17.adjusted)
                    .weight(.bold))
            
            Spacer()
            
            Button(action: {
                self.appState.moveToRootView = true
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 15, height: 15)
            })
            .foregroundColor(.gray900)
        }
        .padding(.horizontal, 20)
    }
    private var ListTitle: some View {
        HStack{
            Text(viewModel.dateString)
                .foregroundColor(Color("Gray900"))
                .font(.pretendard(.bold, size: 20.adjusted))

            Spacer()
        
            Button {
                isShowingUpdateItemView = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(Color("Gray100"))
                    
                    Text("편집")
                        .foregroundColor(Color("Gray400"))
                        .font(.pretendard(.regular, size: 14.adjusted))
                }
                .frame(maxWidth: 60, maxHeight: 32)
                .foregroundColor(Color("Gray100"))
                .padding(.trailing, 20)
            }
            
        }
        .padding(.top, 46)
        .padding(.bottom, 38)
    }
    
    private var ListContents: some View{
        List{
            VStack{
                listDetail(listTraling: "품목", listLeading: "금액", listColor: "Gray400", leadingTitle: 14)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                Divider()
                    .background(Color.gray100)
                    .listRowInsets(EdgeInsets())
            }
            .listRowInsets(EdgeInsets())
            .padding(.bottom, 10)
            
            
            ForEach(0..<gptAnswer["상품명"]!.count, id: \.self) { index in
                let productName = gptAnswer["상품명"]![index] as! String
                let quantity = gptAnswer["수량"]![index] as! Int
                let price = gptAnswer["금액"]![index] as! Int
                
                listDetail(listTraling: productName, listLeading: String(price) + "원", listColor: "Gray900", leadingTitle: 17)
                    .listRowInsets(EdgeInsets())
                
                Divider()
                    .background(Color.gray100)
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 5)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    
    // TODO: listTraling에 품목을, listLeading에 금액을 넣어야 해요.
    private func listDetail(listTraling: String, listLeading: String, listColor: String, leadingTitle: CGFloat) -> some View{
        return HStack{
            Text(listTraling)
                .foregroundColor(Color(listColor))
                .font(.pretendard(.semiBold, size: leadingTitle))
            
            Spacer()
            
            Text(listLeading)
                .foregroundColor(Color(listColor))
                .font(.pretendard(.semiBold, size: 14.adjusted))
        }
        .padding(.horizontal, 20.adjusted)
    }
    
    
    func registerItemsToCoreData() {
        for i in 0..<gptAnswer["상품명"]!.count {
            coreDataViewModel.createReceiptData(name: gptAnswer["상품명"]![i] as! String, price: abs(Double(gptAnswer["금액"]![i] as! Int)), date: viewModel.date)
        }
    }
}

struct ItemCheckView_Previews: PreviewProvider {

    static var previews: some View {
        OCRItemCheckView(gptAnswer: .constant(["test": ["Test Value"]]), appState: AppState())
    }
}
