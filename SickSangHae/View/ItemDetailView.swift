//
//  ItemDetailView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct ItemDetailView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 8, height: 14.2)
                Spacer()
                Text("계란 30구")
                    .bold()
                    .padding(.leading, 15)
                Spacer()
                Text("수정")
            }
            .padding(.horizontal, 20)
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView()
    }
}
