//
//  BasicList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct BasicList: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @State var isDescending = true
    
    @State var appState: AppState
    
    var body: some View {
        ScrollView {
            PinnedListTitle
            ListContent(coreDataViewModel: coreDataViewModel, listContentViewModel: ListContentViewModel(status: .shortTermPinned, itemList: coreDataViewModel.shortTermPinnedList), isDescending: true, appState: appState)
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: screenWidth, height: 12)
                .background(Color("Gray100"))
            
            BasicListTitle
            ListContent(coreDataViewModel: coreDataViewModel, listContentViewModel: ListContentViewModel(status: .shortTermUnEaten, itemList: coreDataViewModel.shortTermUnEatenList), isDescending: isDescending, appState: appState)

        }
        .listStyle(.plain)
        
    }
    
    var BasicListTitle: some View {
            HStack {
                Text("기본")
                    .foregroundColor(Color("Gray900"))
                    .font(.system(size: 20).weight(.semibold))
                
                Spacer()
                
                Button {
                    isDescending.toggle()
                } label: {
                    HStack(spacing: 2) {
                        Text(isDescending ? "최신순" : "오래된순")
                            .foregroundColor(Color("Gray600"))
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                .foregroundColor(Color("Gray600"))
                .font(.system(size: 14))
                .padding(.trailing, 20)
            }
            .padding([.top, .bottom], 17)
            .padding(.leading, 20)
    }
    
    private var PinnedListTitle: some View {
            HStack {
                Text("빨리 먹어야 해요 🕖")
                    .foregroundColor(Color("Gray900"))
                    .font(.system(size: 20).weight(.semibold))
                
                Spacer()
            }
            .padding(.vertical, 17)
            .padding(.horizontal, 20)
        }
}






private struct ListContent: View {
    @ObservedObject var coreDataViewModel: CoreDataViewModel
    @ObservedObject var listContentViewModel: ListContentViewModel
    
    @State var isDescending: Bool
    
    let appState: AppState
    
    init(coreDataViewModel: CoreDataViewModel, listContentViewModel: ListContentViewModel, isDescending: Bool, appState: AppState) {
        self.coreDataViewModel = coreDataViewModel
        self.listContentViewModel = listContentViewModel
        self.isDescending = isDescending
        self.appState = appState
    }
    
    var sortedReceipts: Array<(Int, Receipt)> {
        isDescending ? Array(zip(listContentViewModel.itemList.indices, listContentViewModel.itemList)) :
Array(zip(listContentViewModel.itemList.indices, listContentViewModel.itemList.reversed()))
    }
    
    var body: some View {
        ForEach(sortedReceipts, id:\.0) { index, item in
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
                                .font(.system(size: 17).weight(.semibold))
                                .foregroundColor(Color("Gray900"))
                            
                            Spacer()
                            
                            Text("구매한지 \(item.dateOfPurchase.dateDifference)일")
                                .foregroundColor(Color("Gray900"))
                                .font(.system(size: 14).weight(.semibold))
                                .padding(.trailing, 20)
                        }
                        .padding(.vertical, 8)
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

class ListContentViewModel: ObservableObject {
    
    let status: Status
    @Published var itemList: [Receipt]
    @Published var offsets: [CGFloat]
    
    init(status: Status, itemList: [Receipt]) {
        self.status = status
        self.itemList = itemList
        self.offsets = [CGFloat](repeating: 0, count: itemList.count)
    }
}

struct BasicList_Previews: PreviewProvider {
    static let previewCoreDataViewModel = CoreDataViewModel()
    static var previews: some View {
        BasicList(appState: AppState())
            .environmentObject(previewCoreDataViewModel)
    }
}
