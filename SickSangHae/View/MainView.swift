//
//  MainView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct MainView: View {
  var body: some View {

      VStack(alignment: .leading){
          Spacer()
              .frame(height: 39.adjusted)
          HStack(alignment: .top){
              Spacer()
                  .frame(width: 23.adjusted)
              Text("기본")
                  .font(.system(size: 28.adjusted))
              Text("장기보관")
                  .font(.system(size: 28.adjusted))
          }
          .padding()

          TabBarView()
      }

  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
