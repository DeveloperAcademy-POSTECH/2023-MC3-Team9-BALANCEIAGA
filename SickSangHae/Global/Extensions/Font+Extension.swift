//
//  Font+Extension.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/25.
//

import SwiftUI

extension Font {
  enum Pretendard {
    case bold
    case semiBold
    case medium
    case regular
    case custom(String)
    
    var value : String {
      switch self {
      case .bold :
        return "Pretendard-Bold"
      case .semiBold :
        return "Pretendard-SemiBold"
      case .regular :
        return "Pretendard-Regular"
      case .medium :
        return "Pretendard-Medium"
      case .custom(let name):
        return name
      }
    }
  }
  static func pretendard(_ type: Pretendard, size: CGFloat) -> Font {
    return .custom(type.value, size: size)
  }
}
