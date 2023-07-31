//
//  Gradient+Extension.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/31.
//

import SwiftUI

extension Gradient {
    public static let selectedGradient = Gradient(colors: [Color("PrimaryG"), Color("PrimaryB")])
    public static let notSelectedGradient = Gradient(colors: [Color("Gray200"), Color("Gray200")])
    public static let clearGradient = Gradient(colors: [.clear, .clear])
}
