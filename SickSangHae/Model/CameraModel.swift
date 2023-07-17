//
//  CameraModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/13.
//

import SwiftUI
import AVFoundation

class CameraModel: NSObject, ObservableObject {
  @Published var recentImage: UIImage?
  @Published var isCameraBusy = false
  
  var session = AVCaptureSession()
  var videoDeviceInput : AVCaptureDeviceInput!
  let output = AVCapturePhotoOutput()
  var photoData = Data(count: 0)
  var flashMode: AVCaptureDevice.FlashMode = .off
  
  //MARK: - 카메라 setup 함수
  
  func setUpCamera() {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else { return }
      guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                 for: .video,
                                                 position: .back) else {
        print("Failed to get AVCaptureDevice")
        return
      }
      
      do {
        self.videoDeviceInput = try AVCaptureDeviceInput(device: device)
        if self.session.canAddInput(self.videoDeviceInput) {
          self.session.addInput(self.videoDeviceInput)
        }
        if self.session.canAddOutput(self.output) {
          self.session.addOutput(self.output)
          self.output.maxPhotoQualityPrioritization = .quality
        }
          //백그라운드 스레드에서 호출
        self.session.startRunning()
      } catch {
        print("Failed to set up cameraL \(error)")
      }
    }
  }
  
  //MARK: - 카메라 권한 상태 확인 함수
  
  func requestAndCheckPermissions() {
    let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

    switch authorizationStatus {
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
        DispatchQueue.main.async {
        if granted {
            self?.setUpCamera()
          }
        }
      }
    case .authorized:
      setUpCamera()
    default:
      print("Camera Permission declined")
    }
  }
  
  //MARK: - 사진 촬영 함수
  
  func capturePhoto() {
    let photoSettings = AVCapturePhotoSettings()
    
    photoSettings.flashMode = self.flashMode
    self.output.capturePhoto(with: photoSettings, delegate: self)
    print("[Camera]: Photo's taken")
  }
  
  //MARK: - 사진 저장
  
  func savePhoto(_ imageData: Data) {
    guard let image = UIImage(data: imageData) else { return }
    let screenSize = UIScreen.main.bounds.size
    let resizedImage = resizeImage(image, to: screenSize)
    
    UIImageWriteToSavedPhotosAlbum(resizedImage, nil, nil, nil)
    print("[Camera]: Photo saved")
  }
  
  func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
    let render = UIGraphicsImageRenderer(size: size)
    let resizedImage = render.image { context in
      image.draw(in: CGRect(origin: .zero, size: size))
    }
    return resizedImage
  }
  
  //MARK: - 줌 기능
  
  func zoom(_ zoom: CGFloat) {
    let factor = zoom < 1 ? 1 : zoom
    let device = self.videoDeviceInput.device
    
    do {
      try device.lockForConfiguration()
      device.videoZoomFactor = factor
      device.unlockForConfiguration()
    } catch {
      print(error.localizedDescription)
    }
  }
}

extension CameraModel: AVCapturePhotoCaptureDelegate {
  
  func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    self.isCameraBusy = true
  }
  
  func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
    guard let imageData = photo.fileDataRepresentation() else {
      print("Can't get photo data")
      return
    }
    
    self.recentImage = UIImage(data: imageData)
    self.savePhoto(imageData)
    self.isCameraBusy = false
    print("[CameraModel]: Capture routine's done")
  }
}




