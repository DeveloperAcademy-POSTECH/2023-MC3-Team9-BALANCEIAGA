//
//  GetScreenShotView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

struct GetScreenShotView: View {
  @ObservedObject var viewModel = CameraViewModel()
  @ObservedObject private var model = CameraModel()
  @Environment(\.dismiss) private var dismiss
    let appState: AppState
  var image: UIImage
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .top) {
        Color.white
          .ignoresSafeArea(.all)
        VStack {
          HStack {
            Button(action:{ dismiss() }) {
              Image(systemName:"chevron.left")
                .resizable()
                .frame(width: 11.adjusted, height: 19.adjusted)
                .foregroundColor(.black)
            }
            Spacer()
            //navigation 추가
              NavigationLink(destination: OCRView(image: model.resizeImage(image, to: UIScreen.main.bounds.size), appState: appState)) {
              Text("등록")
                .foregroundColor(.black)
                .font(.system(size: 17.adjusted).bold())
            }
          }
          .padding([.leading, .trailing], 20.adjusted)
          .padding(.top, 10.adjusted)
          
          Image(uiImage: image)
            .resizable()
            .frame(width: screenWidth, height: screenWidth * 1.3)
            .aspectRatio(contentMode: .fit)
            .padding(.top, 90.adjusted)
          
        }
      }
    }
    .navigationBarBackButtonHidden(true)


  }
}

