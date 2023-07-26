//
//  ItemCheckView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct ItemCheckView: View {
    @Binding var gptAnswer: Dictionary<String, [Any]>

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear(){
                print(gptAnswer)
            }
        VStack {
                    ForEach(gptAnswer.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Text("\(key): \(formatValue(value))")
                    }
                }
    }

    func formatValue(_ value: [Any]) -> String {
            return value.map { String(describing: $0) }.joined(separator: ", ")
        }
}

//struct ItemCheckView_Previews: PreviewProvider {
//    @State private var dictionaryBinding: Dictionary<String, [Any]> = ["상품명": ["안판닭감정", "삿포로캔500ML", "코젤다크캔 500ml", "데스페라도스캔 ⑧ ⅝57¾500", "청바오전 500 에누리(행사)", "당당국산돼지갈비맛 팝세."], "수량": [1, 9, 1, 2, 1, 1], "금액": [3588, 5310, 3000, 6000, 3000, 3000], "단가": [35881, 590, 3000, 3000, 3000, 3000]]
//
//    static var previews: some View {
//        ItemCheckView(gptAnswer: $dictionaryBinding)
//    }
//}
