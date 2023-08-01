//
//  NotificationViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/31.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    var currentCase: notificationCase
    @Published var day: Int = 1
    @Published var selectedOption: Int = 1
    
    init(currentCase: notificationCase) {
        self.currentCase = currentCase
    }
    
    func updateDay(for selectedIndex: Int) {
        switch selectedIndex {
        case 1:
            day = 1
        case 2:
            day = 2
        case 3:
            day = 3
        default:
            day = 1
        }
    }
    
}
