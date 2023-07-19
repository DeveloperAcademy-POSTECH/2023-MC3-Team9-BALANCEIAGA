//
//  BasicList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct BasicList: View {
    @StateObject var coreDataViewModel = CoreDataViewModel()
    @State private var ascending = false
    
    var body: some View {
        VStack {
            NavigationStack {
                ListViewTemplate(title: "빨리 먹어야 해요 🕖", buttonTitle: "최신순", coreDataViewModel:
                                    coreDataViewModel)
            }
            
            Rectangle()
            .foregroundColor(.clear)
            .frame(width: 390.adjusted, height: 12.adjusted)
            .background(.gray)
//            .background("Gray100")
            
            NavigationStack {
                ListViewTemplate(title: "기본", buttonTitle: "최신순", coreDataViewModel: coreDataViewModel)
            }
            
            Button("코어데이터 만들기") {
                coreDataViewModel.createReceiptData()
                print(coreDataViewModel.receipts.count)
            }
        }
    }
    
    struct ListViewTemplate: View {
        let title: String
        let buttonTitle: String
        @ObservedObject var coreDataViewModel:  CoreDataViewModel
        
        var body: some View {
            VStack {
                List {
                    ForEach(coreDataViewModel.receipts, id: \.self) { testList in
                        
                        HStack{
                            
                            // 이 부분 빈 문자열이 없으면 이미지 밑에 구분선이 왜 없어질까요?
                            Text("")
                                .foregroundColor(.clear)
                            
                            Image(systemName: "circle.fill")
                                .resizable()
                            //                                   .foregroundColor(Color("Gray200"))
                                .frame(width: 36.adjusted, height: 36.adjusted)
                            
                            Text(testList.name)
                            //                                   .foregroundColor(Color("Gray900"))
                                .font(.system(size: 17.adjusted).weight(.semibold))
                            //                            .font(.custom("Pretendard-Bold", size: 20)) // Pretendard Bold 폰트 적용
                            Spacer()
                            
                            Text("구매한지 x일")
                            //                                   .foregroundColor(Color("Gray900"))
                                .font(.system(size: 14.adjusted).weight(.semibold))
                        }
                    }
                    .padding(.vertical, 16.adjusted)
                }
                .listStyle(.plain)
                .padding(.top, 27.adjusted)
                .navigationBarItems(leading: leadingText(title: title), trailing: trailingButton(buttonTitle: buttonTitle))
            }
        }
    }
    
    struct leadingText: View {
        let title: String
        var body: some View {
            Text(title)
            //                   .foregroundColor(Color("Gray900"))
                .font(.system(size: 20.adjusted).weight(.bold))
                .padding(.top, 27.adjusted)
        }
    }

    struct trailingButton: View {
        let buttonTitle: String
        var body: some View {
            Button(action: {
                // Your action for the trailing button
            }) {
                Text(buttonTitle)
                Image(systemName: "arrow.up.arrow.down")
            }
            //               .foregroundColor(Color("Gray600"))
            .font(.system(size: 14.adjusted).weight(.semibold))
            .padding(.top, 27.adjusted)
        }
    }
    
}

struct BasicList_Previews: PreviewProvider {
    static var previews: some View {
        BasicList()
    }
}
