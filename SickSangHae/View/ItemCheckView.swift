//
//  ItemCheckView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct ItemCheckView: View {
    
    var items = ["a", "b", "c", "d"]
    // TODO: 나중에 뷰 연결할때는 @Binding으로 바꾸어야할 듯합니다.
    var isOCR = true
    @ObservedObject var viewModel = UpdateItemViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
                            dismiss()
                            dismiss()
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
                    NavigationLink(destination: RegisterCompleteView(), label: {
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
            
            switch isOCR{
            case true:
                NavigationLink(destination: UpdateItemView(viewModel: UpdateItemViewModel()), label: {
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
                })
            default:
                EmptyView()
            }
            
        }
        .padding([.top, .bottom], 17.adjusted)
        .padding([.leading], 20.adjusted)
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
                
                ForEach(items, id: \.self) { item in
                    listDetail(listTraling: item, listLeading: "8,000원", listColor: "Gray900")
                    
                    Divider()
                        .overlay(Color("Gray100"))
                }
                .padding([.horizontal], 40.adjusted)
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
    
}

struct ItemCheckView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCheckView()
    }
}
