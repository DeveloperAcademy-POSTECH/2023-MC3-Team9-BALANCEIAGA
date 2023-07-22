//
//  LongTermList.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct LongTermList: View {
    let testLists = ["계란 30구","모둠쌈","요플레","요플레","모둠쌈","라면","양파","계란","모둠쌈","요플레","모둠쌈","모둠쌈","계란","요플레","모둠쌈","요플레"]

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
                .font(.system(size: 20.adjusted).weight(.bold))

            Spacer()

            Button{

            } label: {

                HStack(spacing: 2.adjusted){
                    Text("최신순")
                        .foregroundColor(Color("Gray600"))
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .foregroundColor(Color("Gray600"))
            .font(.system(size: 14.adjusted))
            .padding(.trailing, 20.adjusted)
        }
        .padding([.top, .bottom], 17.adjusted)
        .padding([.leading], 20.adjusted)
    }

    private var ListContents: some View{
        ForEach(testLists, id: \.self) { testList in
            HStack(spacing: 0){

                // 이 부분 빈 문자열이 없으면 이미지 밑에 구분선이 왜 없어질까요?
                Text("")
                    .foregroundColor(.clear)

                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(Color("Gray200"))
                    .frame(width: 36.adjusted, height: 36.adjusted)

                Spacer()
                    .frame(width: 12.adjusted)

                Text(testList)
                    .foregroundColor(Color("Gray900"))
                    .font(.system(size: 17.adjusted).weight(.semibold))

                Spacer()

                Text("구매한지 x일")
                    .foregroundColor(Color("Gray900"))
                    .font(.system(size: 14.adjusted).weight(.semibold))
                    .padding(.trailing, 20.adjusted)
            }
            .padding([.top, .bottom], 8.adjusted)

            Divider()
                .overlay(Color("Gray100"))
                .opacity(testList == data.last ? 0 : 1)
        }
        .padding([.leading], 20.adjusted)
    }
}


struct LongTermList_Previews: PreviewProvider {
    static var previews: some View {
        LongTermList()
    }
}
