//
//  CameraView.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
  @ObservedObject var viewModel = CameraViewModel()
  
  var body: some View {
    ZStack {
      viewModel.cameraPreview.ignoresSafeArea()
        .onAppear {
          viewModel.configure()
        }
        .gesture(MagnificationGesture()
          .onChanged { val in
            viewModel.zoom(factor: val)
          }
          .onEnded { _ in
            viewModel.zoomInitialize()
          }
        )
      VStack {
        Spacer()
        HStack {
          Button {
            viewModel.imagePickerPresented.toggle()
          } label: {
            Image("ic_gallery")
              .padding(.leading, 32.adjusted)
          }
          Spacer()
          Button(action: {
            viewModel.capturePhoto()}) {
              Image("img_cameraShutter")
            }
          Spacer()
          Button(action: {viewModel.switchFlash()}) {
            Image(systemName: viewModel.isFlashOn ?
                  "bolt.fill" : "bolt.slash")
            .foregroundColor(.white)
          }
        }
      }
      .foregroundColor(.white)
      /// ImagePicker
      .sheet(isPresented: $viewModel.imagePickerPresented, onDismiss: {
        viewModel.OCRViewPresented.toggle()
      }) {
        ImagePicker(image: $viewModel.selectedImage, isPresented: $viewModel.imagePickerPresented)
      }
    }
  }
}

