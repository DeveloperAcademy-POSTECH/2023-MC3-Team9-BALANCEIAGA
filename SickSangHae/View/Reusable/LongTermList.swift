//
//  LongTermList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct LongTermList: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    let itemList: [Receipt]
    let status: Status
    @State private var swipeOffsets: [CGFloat]
    
    
    init(itemList: [Receipt], swipeOffsets: [CGFloat], status: Status) {
        self.itemList = itemList
        self.status = status
        self.swipeOffsets = swipeOffsets
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
                .font(.system(size: 20).weight(.bold))

            Spacer()

            Button{

            } label: {

                HStack(spacing: 2){
                    Text("최신순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14))
            .padding(.trailing, 20)
        }
        .padding([.top, .bottom], 17)
        .padding([.leading], 20)
    }

    private var ListContents: some View{
        VStack {
            ForEach(Array(zip(itemList.indices, itemList)), id:\.0) { index, item in
                ZStack {
                    HStack {
                        Button {
                            withAnimation {
                                coreDataViewModel.updateStatus(target: item, to: .Eaten)
                            }
                            swipeOffsets[index] = 0
                        } label: {
                            Image(systemName: "fork.knife")
                        }
                        .frame(width: 70, height: 60)
                        .background(.green)
                        .foregroundColor(.white)
                        .opacity(swipeOffsets[index] > 0 ? 1 : 0)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                coreDataViewModel.updateStatus(target: item, to: .Spoiled)
                            }
                            swipeOffsets[index] = 0
                        } label: {
                            Image(systemName: "allergens.fill")
                        }
                        .frame(width: 70, height: 60)
                        .background(.red)
                        .foregroundColor(.white)
                        .opacity(swipeOffsets[index] < 0 ? 1 : 0)
                    }
                    
                    
                    ZStack {
                        Rectangle()
                            .fill(.white)
                        HStack(spacing: 0) {
                            Text("")
                                .foregroundColor(.clear)
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                                .foregroundColor(Color("Gray200"))
                                .frame(width: 36, height: 36)
                                .padding(.leading, 20)
                            
                            Spacer()
                                .frame(width: 12)
                            
                            Text(item.name)
                                .font(.system(size: 17).weight(.semibold))
                                .foregroundColor(Color("Gray900"))
                            
                            Spacer()
                            
                            Text("구매한지 \(item.dateOfPurchase.dateDifference)일")
                                .foregroundColor(Color("Gray900"))
                                .font(.system(size: 14).weight(.semibold))
                                .padding(.trailing, 20)
                        }
                        .padding([.top, .bottom], 8)
                    }
                    .offset(x: swipeOffsets[index])
                    .onTapGesture {
                        withAnimation {
                            swipeOffsets[index] = 0
                        }
                    }
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            swipeOffsets[index] = value.translation.width
                        }
                    })
                        .onEnded({ value in
                            withAnimation {
                                if value.translation.width < -60 {
                                    swipeOffsets[index] = -70
                                } else if value.translation.width > 60 {
                                    swipeOffsets[index] = 70
                                } else {
                                    swipeOffsets[index] = 0
                                }
                            }
                        }))
                }
                
                Divider()
                    .overlay(Color("Gray100"))
                    .opacity(item == itemList.last ? 0 : 1)
                    .padding([.leading], 20)
            }
            
            
            Button("Add") {
                swipeOffsets.append(0.0)
                coreDataViewModel.createTestReceiptData(status: status)
                print("swipeOffsets.count: \(swipeOffsets.count)")
                print("itemList.count: \(itemList.count)")
            }
            .onAppear {
                print("swipeOffsets.count: \(swipeOffsets.count)")
                print("itemList.count: \(itemList.count)")
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
