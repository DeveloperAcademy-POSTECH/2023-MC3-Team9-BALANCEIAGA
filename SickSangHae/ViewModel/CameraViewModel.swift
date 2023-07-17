//
//  CameraViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/14.
//

import SwiftUI
import AVFoundation
import Combine

class CameraViewModel: ObservableObject {
  private let model: CameraModel
  private let session: AVCaptureSession
  private var subscriptions = Set<AnyCancellable>()
  private var isCameraBusy = false
  
  let cameraPreview: AnyView
  var currentZoomFactor: CGFloat = 1.0
  var lastScale: CGFloat = 1.0
  
  @Published var selectedImage: UIImage?
  @Published var imagePickerPresented: Bool = false
  @Published var showPreview = false
  @Published var shutterEffect = false
  @Published var recentImage: UIImage?
  @Published var isFlashOn = false
  @Published var isShowingText = false
  
  //MARK: - 초기 세팅
  
  func configure() {
    model.requestAndCheckPermissions()
  }
  
  //MARK: - 플래시 기능
  
  func switchFlash() {
    isFlashOn.toggle()
    model.flashMode = isFlashOn == true ? .on : .off
  }
  
  //MARK: - 사진 촬영
  
  func capturePhoto() {
    if !isCameraBusy {
      withAnimation(.easeInOut(duration: 0.1)) {
        shutterEffect = true
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        withAnimation(.easeInOut(duration: 0.1)) {
          self.shutterEffect = false
        }
      }
      
      model.capturePhoto()
      print("[CamerViewModel]: Photo Captured!")
    } else {
      print("[CameraViewModel]: Camera's busy.")
    }
  }
  
  //MARK: - 줌 기능
  
  func zoom(factor: CGFloat) {
    let delta = factor / lastScale
    lastScale = factor
    let newScale = min(max(currentZoomFactor * delta, 1), 5)
    
    model.zoom(newScale)
    currentZoomFactor = newScale
  }
  
  func zoomInitialize() {
    lastScale = 1.0
  }
  
  func startShowingText() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      withAnimation {
        self?.isShowingText = false
      }
    }
  }
  
  
  init() {
    model = CameraModel()
    session = model.session
    cameraPreview = AnyView(CameraPreviewView(session: session))
    
    model.$recentImage.sink { [weak self] (photo) in
      guard let picture = photo else { return }
      self?.recentImage = picture
    }
    .store(in: &self.subscriptions)
    
    model.$isCameraBusy.sink{ [weak self] (result) in
      self?.isCameraBusy = result
    }
    .store(in: &self.subscriptions)
  }
  
  
}
