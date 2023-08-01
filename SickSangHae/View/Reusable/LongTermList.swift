//
//  LongTermList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct LongTermList: View {
    @ObservedObject var coreDataViewModel: CoreDataViewModel
    @ObservedObject var listContentViewModel: ListContentViewModel
    @State private var isDescending = true
    
    let appState: AppState
    
    init(coreDataViewModel: CoreDataViewModel, listContentViewModel: ListContentViewModel, appState: AppState) {
        self.coreDataViewModel = coreDataViewModel
        self.listContentViewModel = listContentViewModel
        self.appState = appState
    }
    
    var sortedReceipts: Array<(Int, Receipt)> {
        isDescending ? Array(zip(listContentViewModel.itemList.indices, listContentViewModel.itemList)) :
Array(zip(listContentViewModel.itemList.indices, listContentViewModel.itemList.reversed()))
    }

    var body: some View {

        ScrollView {
            ListTitle
            ListContents
        }
        .listStyle(.plain)
    }

    private var ListTitle: some View {
        HStack{
            Text("천천히 먹어도 돼요")
                .foregroundColor(Color("Gray900"))
                .font(.pretendard(.bold, size: 20))

            Spacer()

            Button{
                isDescending.toggle()
            } label: {
                HStack(spacing: 2){
                    Text(isDescending ? "최신순" : "오래된순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.pretendard(.medium, size: 14))
            .padding(.trailing, 20)
        }
        .padding([.top, .bottom], 17)
        .padding(.leading, 20)
    }

    private var ListContents: some View {
        Group {
            ForEach( sortedReceipts,
                id:\.0) { index, item in
                ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                coreDataViewModel.updateStatus(target: item, to: .Eaten)
                            }
                            listContentViewModel.offsets[index] = 0
                        } label: {
                            Image(systemName: "fork.knife")
                        }
                        .frame(width: 70, height: 60)
                        .background(.green)
                        .foregroundColor(.white)
                        .opacity(listContentViewModel.offsets[index] > 0 ? 1 : 0)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                coreDataViewModel.updateStatus(target: item, to: .Spoiled)
                            }
                            listContentViewModel.offsets[index] = 0
                        } label: {
                            Image(systemName: "allergens.fill")
                        }
                        .frame(width: 70, height: 60)
                        .background(.red)
                        .foregroundColor(.white)
                        .opacity(listContentViewModel.offsets[index] < 0 ? 1 : 0)
                    }
                    
                    NavigationLink {
                        ItemDetailView(receipt: item, appState: appState)
                            .environmentObject(coreDataViewModel)
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.white)
                            HStack(spacing: 0) {
                                Text("")
                                    .foregroundColor(.clear)
                                
                                Image(item.icon)
                                    .resizable()
                                    .foregroundColor(Color("Gray200"))
                                    .frame(width: 36, height: 36)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                    .frame(width: 12)

                                Text(item.name)
                                    .font(.pretendard(.semiBold, size: 17))
                                    .foregroundColor(Color("Gray900"))
                                
                                Spacer()
                                
                                Text("구매한지 \(item.dateOfPurchase.dateDifference)일")
                                    .foregroundColor(Color("Gray900"))
                                    .font(.pretendard(.semibold, size: 14))
                                    .padding(.trailing, 20)
                            }
                            .padding([.top, .bottom], 8)
                        }
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation {
                                listContentViewModel.offsets[index] = value.translation.width
                            }
                        })
                            .onEnded ({ value in
                                withAnimation {
                                    let translationWidth = value.translation.width
                                    switch translationWidth {
                                    case ..<(-60):
                                        listContentViewModel.offsets[index] = -70
                                    case 60...:
                                        listContentViewModel.offsets[index] = 70
                                    default:
                                        listContentViewModel.offsets[index] = 0
                                    }
                                }
                            }))
                    }
                    .offset(x: listContentViewModel.offsets[index])
                    
                    
                }
                
                Divider()
                    .overlay(Color("Gray100"))
                    .opacity(item == listContentViewModel.itemList.last ? 0 : 1)
                    .padding(.leading, 20)
            }
            
            
            Button("Add") {
                listContentViewModel.offsets.append(0.0)
                coreDataViewModel.createTestReceiptData(status: listContentViewModel.status)
            }
        }
    }
}


//struct LongTermList_Previews: PreviewProvider {
//    static let coreDataViewModel = CoreDataViewModel()
//    static var previews: some View {
//        LongTermList()
//            .environmentObject(coreDataViewModel)
//    }
//}
