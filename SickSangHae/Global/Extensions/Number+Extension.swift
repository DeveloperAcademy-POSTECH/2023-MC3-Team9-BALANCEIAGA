//
//  CGFloat+Extension.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/13.
//
import SwiftUI

let screen = UIScreen.main.bounds
let screenWidth = screen.width
let screenHeight = screen.height

extension CGFloat {
  var adjusted: CGFloat {
    let ratio: CGFloat = screenWidth / 390
    let ratioH: CGFloat = screenHeight / 844
    return ratio <= ratioH ? self * ratio : self * ratioH
  }
}

extension Int {
  public var adjusted: CGFloat {
    let ratio: CGFloat = screenWidth / 390
    let ratioH: CGFloat = screenHeight / 844
    return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
  }
}

extension Double {
  public var adjusted: CGFloat {
    let ratio: CGFloat = screenWidth / 390
    let ratioH: CGFloat = screenHeight / 844
    return ratio <= ratioH ? CGFloat(self) * ratio : CGFloat(self) * ratioH
  }
}
