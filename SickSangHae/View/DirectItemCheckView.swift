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
    @State private var isShowingModal = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack {
                    ZStack(alignment: .top){
                        ZigZagShape()
                            .fill(Color.gray50)
                            .ignoresSafeArea()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 162)
                        VStack{
                            NavBar
                            
                            HStack {
                                Text("아래 식료품을 등록할게요.")
                                    .foregroundColor(Color("Gray400"))
                                    .font(.pretendard(.semiBold, size: 20))
                                    .padding(.top, 55)
                            }
                        }
                        .padding(.top, 13)
                    }
                    
                    ListTitle
                    
                    ListContents

                    Spacer()

                    Button{
                        registerItemsToCoreData()
                        Analyzer.sendGA(DirectItemCheckViewEvents.registerButton)
                        isShowingModal = true
                    } label: {
                        ZStack{
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
            }
            .onAppear {
                Analyzer.sendGA(DirectItemCheckViewEvents.appear)
            }
//            .onDisappear(){
//                //MARK: 이 부분때문에 그냥 꺼도 아이템이 CoreData에 등록됨(BugFix)
//                registerItemsToCoreData()
//            }
            .navigationBarBackButtonHidden(true)
        }
        .fullScreenCover(isPresented: $isShowingModal){
            RegisterCompleteView(appState: appState)
        }
    }
    private var NavBar: some View{
        HStack {
            Button(action:{
                Analyzer.sendGA(DirectItemCheckViewEvents.backButton)
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 10, height: 19)
                    .foregroundColor(.gray900)
            })
            
            Spacer()
            
            Text("직접 추가")
                .foregroundColor(Color("Gray900"))
                .font(.system(size: 17.adjusted)
                    .weight(.bold))
            
            Spacer()
            
            Button(action: {
                Analyzer.sendGA(DirectItemCheckViewEvents.xmarkButton)
                self.appState.moveToRootView = true
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 15, height: 15)
            })
            .foregroundColor(.gray900)
        }.padding(.horizontal, 20)
    }
    private var EditButton: some View {
        Button(){
            
        }label: {
            ZStack{
                Rectangle()
                    .frame(maxWidth: 60, maxHeight: 32)
                    .foregroundColor(Color.gray100)
                    .cornerRadius(12)
                    .padding()
                Text("편집")
                    .font(.system(size: 14.adjusted)
                    .weight(.semibold))
                    .foregroundColor(Color.gray400)
            }
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
        .padding([.top, .bottom], 17.adjusted)
        .padding(.leading, 20.adjusted)
    }

    private var ListContents: some View{
        List{
            VStack{
                listDetail(listTraling: "품목", listLeading: "금액", listColor: "Gray400", leadingTitle: 14)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .padding(.bottom, 6)
                
                Divider()
                    .background(Color.gray100)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 10)
            }
            .listRowInsets(EdgeInsets())
            .padding(.bottom, 10)
            
            ForEach(viewModel.itemBlockViewModels, id: \.self) { item in
                
                listDetail(listTraling: item.name, listLeading: String(item.price) + "원", listColor: "Gray900", leadingTitle: 17)
                    .listRowInsets(EdgeInsets())
                
                Divider()
                    .overlay(Color.gray100)
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
        .padding(.horizontal, 40)
    }


    func registerItemsToCoreData() {
        viewModel.itemBlockViewModels.forEach { item in
            coreDataViewModel.createReceiptData(name: item.name, price: abs(Double(item.price)), date: viewModel.date)
        }
    }
}

struct DirectItemCheckView_Previews: PreviewProvider {

    static var previews: some View {
        DirectItemCheckView(viewModel: UpdateItemViewModel(),appState: AppState())
    }
}
