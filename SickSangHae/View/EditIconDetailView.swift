//
//  EditIconDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct EditIconDetailView: View {
    let iconTitles = ["건강식품", "견과류","곡류", "과일류", "과자류", "냉동식품류", "달걀", "델리/초간단식", "떡류", "만두", "면류", "밀키트", "밥", "빵류", "소스류", "수산물", "시리얼", "식용유류", "아이스크림", "우유/유제품", "육류", "음료류", "장류", "조미료류", "주류", "즉석식품류", "잼류", "차", "초콜릿류", "치킨", "채소류", "커피", "콩류", "통조림류", "해조류", "햄/소시지류"]
    
    let iconImages = ["supplements", "nuts", "grains", "fruits", "snacks", "frozenFoods", "eggs", "deliFoods", "ddeuk", "dumples", "noodles", "mealkits", "rices", "breads", "sauces", "seafoods", "cereals", "cookingOils", "iceCream", "dairies", "meats", "beverages", "koreanSauces", "seasonings", "liquors", "retortFoods", "jams", "teas", "chocolates", "friedChicken", "vegetables", "coffee", "beans", "cannedFoods", "seaweeds", "hamSausage"]
    
    var iconDict: Dictionary<String, String> {
        Dictionary(uniqueKeysWithValues: zip(iconImages, iconTitles))
    }
    
    @Binding var receiptIcon: String
    @State var currentIcon: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack {
            
            HStack {
                Button(action: {
                    Analyzer.sendGA(EditIconDetailViewEvents.cancel)
                    dismiss()
                }, label: {
                    Text("취소")
                        .bold()
                        .foregroundColor(.black)
                })
                Spacer()
                Button(action: {
                    Analyzer.sendGA(EditIconDetailViewEvents.complete)
                    // 변경된 icon 저장하는 로직
                    receiptIcon = currentIcon
                    dismiss()
                }, label: {
                    Text("완료")
                        .bold()
                        .foregroundColor(.black)
                })
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            
            ScrollView {
                ZStack(alignment: .topTrailing) {
                    Image(currentIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                    Button {
                        currentIcon = "shoppingCart"
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(Color("Gray100"))
                                .frame(width: 28, height: 28)
                            Circle()
                                .stroke(.white, lineWidth: 2)
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color("Gray900"))
                                        .frame(width: 11, height: 11)
                                )
                                .onTapGesture {
                                    Analyzer.sendGA(EditIconDetailViewEvents.xmark)
                                }
                        }
                    }
                    
                }
//                Text("계란 30구")
                Text(iconDict[currentIcon] ?? "쇼핑카트")
                    .font(.title2)
                    .bold()
                    .padding(screenHeight * 0.028)
                
                LazyVGrid (
                    columns: [GridItem(.adaptive(minimum: 70))]
                ){
                    ForEach(0..<36) { number in
                        Button(action: {
                            Analyzer.sendGA(EditIconDetailViewEvents.iconItem)
                            currentIcon = iconImages[number]
                        }, label: {
                            VStack {
                                Image(iconImages[number])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth * 0.18)
                                Text(iconTitles[number])
                                    .font(.caption)
                                    .foregroundColor(Color("Gray600"))
                            }
                        })
                        
                        .padding(.vertical, 10.adjusted)
                    }
                }
                .padding(20)
            }
        }
        .onAppear {
            Analyzer.sendGA(EditIconDetailViewEvents.appear)
        }
    }
}

struct EditIconDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EditIconDetailView(receiptIcon: .constant("bread"), currentIcon: "shoppingCart")
    }
}
