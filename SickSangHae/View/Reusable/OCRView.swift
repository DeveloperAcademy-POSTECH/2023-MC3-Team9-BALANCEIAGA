//
//  OCRView.swift
//  SickSangHae
//
//  Created by CHANG JIN LEE on 2023/07/15.
//

import SwiftUI

struct OCRView: View {
    @ObservedObject private var viewModel = OCRViewModel()
    @Environment(\.dismiss) private var dismiss
    var image: UIImage
    @State private var isMovingDown = true
    @State private var isShowBoundingBoxView = true
    @State private var isShowScanView = false
    @State private var isShowItemCheckView = false
    @State private var gptAnswer: String = ""

    let appState: AppState
    let dispatchGroup = DispatchGroup()
    
    var body: some View {
        GeometryReader { geometry in
            Image(uiImage: image)
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height)
            if isShowBoundingBoxView {
                BoundingBoxView
                    .onAppear {
                        viewModel.recognizeText(image: image)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            isShowBoundingBoxView = false
                            isShowScanView = true
                        }
                    }
            }
            if isShowScanView {
                NavigationLink(destination: ItemCheckView(gptAnswer: $viewModel.gptAnswer, appState: appState), isActive: $isShowItemCheckView) {
                    EmptyView()
                }
                .hidden()
                scanView
                  .onAppear {
                      // MARK: DispatchGroup을 enter 합니다.
                      dispatchGroup.enter()
                      DispatchQueue.main.async {
                          // MARK: viewModel.queryGPT 안에서 DispatchGroup를 leave 합니다.
                          viewModel.queryGPT(prompts: viewModel.gptPrompt, dispatchGroup: dispatchGroup){ word in
                              gptAnswer += word
                              print(gptAnswer)
                          }
                      }

                      dispatchGroup.notify(queue: .main) {
                          // MARK: 여기에 DispatchGroup의 모든 작업이 완료되었을 때 실행할 로직 추가
                          isShowScanView = false
                          isShowItemCheckView = true
                          print(gptAnswer)
                          viewModel.gptAnswer = viewModel.convertToDictionary(text: gptAnswer)!
                      }
                  }
            }
        }
        .navigationBarBackButtonHidden(true)
    }


    private var BoundingBoxView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ForEach(viewModel.textObservations.reversed(), id: \.self) { observation in
                    let transformedRect = CGRect(
                        x: observation.boundingBox.origin.x * geometry.size.width,
                        y: (1 - observation.boundingBox.origin.y - observation.boundingBox.size.height) * geometry.size.height,
                        width: observation.boundingBox.size.width * geometry.size.width,
                        height: observation.boundingBox.size.height * geometry.size.height
                    )

                    Rectangle()
                        .stroke(Color.accentColor, lineWidth: 1)
                        .frame(width: transformedRect.width, height: transformedRect.height)
                        .position(x: transformedRect.midX, y: transformedRect.midY)

                }

                VStack {
                    Spacer()
                    Text("영수증 인식완료!")
                        .font(.system(size: 22).bold())
                        .padding(.bottom, 80.adjusted)
                        .foregroundColor(Color.accentColor)

                }
            }
        }
    }
    private var scanView: some View {
        GeometryReader { geometry in
            Image("img_scan")
                .resizable()
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                .offset(y: isMovingDown ? 0 : geometry.size.height)
                .onAppear {
                    withAnimation(Animation.interpolatingSpring(stiffness: 15, damping: 15).repeatForever(autoreverses: true)) {
                        self.isMovingDown.toggle()
                    }
                }

            Text("영수증 정보를 가져오고 있어요")
                .foregroundColor(.accentColor)
                .position(x: geometry.size.width / 2 ,y: geometry.size.height - 80.adjusted)
        }

    }
}

