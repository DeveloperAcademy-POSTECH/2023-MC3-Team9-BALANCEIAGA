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
  @Environment(\.dismiss) private var dismiss
  @State private var isShowingText = false
  
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
        closeButton
        Spacer()
        alertText
        Spacer()
        
        HStack {
          galleryButton
          Spacer()
          captureButton
          Spacer()
          flashButton
        }
        .foregroundColor(.white)
        .sheet(isPresented: $viewModel.imagePickerPresented) {
          ImagePicker(image: $viewModel.selectedImage, isPresented: $viewModel.imagePickerPresented)
        }
      }
      .onAppear {
        
      }
    }
  }
  
  private var closeButton: some View {
    Button {
      dismiss()
    }label: {
      Spacer()
      Image(systemName: "xmark")
        .resizable()
        .frame(width: 19.adjusted, height: 19.adjusted)
        .foregroundColor(.white)
        .padding(.trailing, 20.adjusted)
        .padding(.top, 11.adjusted)
    }
  }
  
  private var alertText: some View {
    // 폰트 변경 해야함
    Text("영수증의 결제 정보가\n잘 보이도록 찍어주세요")
      .multilineTextAlignment(.center)
      .foregroundColor(.white)
      .font(.system(.title).bold())
      .transition(.opacity)
      .animation(.easeOut(duration: 2))
  }
  
  private var galleryButton: some View {
    Button {
      viewModel.imagePickerPresented.toggle()
    } label: {
      Image("ic_gallery")
        .resizable()
        .frame(width: 29.adjusted, height: 24.adjusted)
    }
  }
  
  private var captureButton: some View {
    Button(action: {
      viewModel.capturePhoto()}) {
        Image("img_cameraShutter")
      }
  }
  
  private var flashButton: some View {
    Button(action: {viewModel.switchFlash()}) {
      Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash")
        .resizable()
        .frame(width: 20.adjusted, height: 26.adjusted)
      
    }
    .foregroundColor(.white)
  }
  
  struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
      override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
      }
      
      var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
      }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
      let view = VideoPreviewView()
      
      view.videoPreviewLayer.session = session
      view.backgroundColor = .black
      view.videoPreviewLayer.videoGravity = .resizeAspectFill
      view.videoPreviewLayer.cornerRadius = 0
      view.videoPreviewLayer.connection?.videoOrientation = .portrait
      
      return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
      
    }
  }
}
