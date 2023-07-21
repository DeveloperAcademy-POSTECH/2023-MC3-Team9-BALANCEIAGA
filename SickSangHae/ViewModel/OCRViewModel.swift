//
//  OCRViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/18.
//

import SwiftUI
import Vision
import VisionKit

class OCRViewModel: ObservableObject {
  @Published var OCRString: String?
  @Published var textObservations: [VNRecognizedTextObservation] = []
  
  //이미지 분석 메소드
  func recognizeText(image: UIImage) {
    guard let image = image.cgImage else {
      fatalError("이미지 오류")
    }
    
    let transform = CGAffineTransform.identity.scaledBy(x: CGFloat(image.width), y: CGFloat(image.height))
    let handler = VNImageRequestHandler(cgImage: image, options: [:])
    let request = VNRecognizeTextRequest { [weak self] request, error in
      guard let result = request.results as? [VNRecognizedTextObservation], error == nil else {
        return
      }

      let text = result.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
      self?.OCRString = text
      print(text)
      
      let requestArr = result.compactMap { $0.topCandidates(1).first?.string }
      print("Request Results: \(requestArr)")
      
      guard let observations = request.results as? [VNRecognizedTextObservation] else {
        return
      }
      
      var textBoundingBoxes: [CGRect] = []
      for observation in observations {
        let transformedRect = observation.boundingBox.applying(transform)
        textBoundingBoxes.append(transformedRect)
      }
      
      DispatchQueue.main.async {
        self?.textObservations = observations
      }
    }
    
    if #available(iOS 16.0, *) {
      request.revision = VNRecognizeTextRequestRevision3
      request.recognitionLanguages = ["ko-KR"]
    } else {
      request.recognitionLanguages = ["en-US"]
    }
    
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    
    do {
      print(try request.supportedRecognitionLanguages())
      try handler.perform([request])
    } catch {
      print(error)
    }
  }
}
  
