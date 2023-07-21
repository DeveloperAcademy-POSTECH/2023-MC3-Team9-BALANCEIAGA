//
//  ImagePickerModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/18.
//

import SwiftUI

//MARK: - UIKit의 ImagePicker를 대신 사용

struct ImagePicker {
  @Binding var image: UIImage?
  @Binding var isPresented: Bool
}

extension ImagePicker : UIViewControllerRepresentable {
  
  typealias UIViewControllerType = UIViewController
  
  func makeUIViewController(context: Context) -> UIViewController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      guard let image = info[.originalImage] as? UIImage else { return }
      self.parent.image = image
      self.parent.isPresented = false
    }
  }
}
