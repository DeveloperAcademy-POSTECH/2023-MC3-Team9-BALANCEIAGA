//
//  TabBarView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

enum Tab {
    case first
    case second
    case third
    case fourth
}

struct TabBarView: View {
    //Custom TabView

    @State var selectedTab: Tab = .first
    var body: some View {
        VStack {
            Spacer()
            switch selectedTab {
            case .first:
                Text("The First Tab")
            case .second:
                Text("The Second Tab")
            case .third:
                Text("The Third Tab")
            case .fourth:
                Text("The Fourth Tab")
            }
            Spacer()

            CustomTabView(selectedTab: $selectedTab)
        }
    }

}

struct CustomTabView: View {
    @Binding var selectedTab: Tab

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)

            Button{
                // 기능을 넣어요
            } label: {
                ZStack{
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: screenWidth, height: 60.adjusted)
                        .foregroundColor(.blueGrayColor)
                        .padding(.bottom, 12.adjusted)
                        .cornerRadius(12.adjusted)
                        .padding(.bottom, -12.adjusted)

                    HStack{
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 20.adjusted))
                        Text("영수증 스캔하기")
                            .font(.system(size: 17.adjusted))
                    }
                    .foregroundColor(.white)

                }
            }
            .padding(.bottom, 150.adjusted)

            HStack {
                Spacer()
                    .frame(width: 10.adjusted)
                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                        Button {
                            selectedTab = .first
                        } label: {
                            VStack{
                                Image(systemName: selectedTab == .first ? "bag.fill" : "bag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25)
                                    .foregroundColor(selectedTab == .first ? .mint : .gray)
                                Text("나의 냉장고")
                                    .foregroundColor(selectedTab == .first ? .mint : .gray)
                                    .font(.system(size: 14.adjusted))
                            }
                        }
                    )

                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .second
                } label: {
                    VStack{
                        Image(systemName: "chart.bar.xaxis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .second ? .mint : .gray)
                        Text("통계")
                            .foregroundColor(selectedTab == .second ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                    }
                }
                )
                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .third
                } label: {
                    VStack{
                        Image(systemName: selectedTab == .third ? "newspaper.fill" : "newspaper")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .third ? .mint : .gray)
                        Text("보관함")
                            .foregroundColor(selectedTab == .third ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                    }
                }
                )
                Spacer()

                Rectangle()
                    .frame(width: 80.adjusted, height: 80.adjusted)
                    .foregroundColor(.clear)
                    .overlay(
                Button {
                    selectedTab = .fourth
                } label: {
                    VStack{
                        Image(systemName: selectedTab == .fourth ? "circle.fill" : "circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(selectedTab == .fourth ? .mint : .gray)
                        Text("설정")
                            .foregroundColor(selectedTab == .fourth ? .mint : .gray)
                            .font(.system(size: 14.adjusted))
                    }
                }
                )
                Spacer()
                    .frame(width: 10.adjusted)
            }





        }
        .frame(height: 90.adjusted)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
