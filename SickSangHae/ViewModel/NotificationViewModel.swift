//
//  NotificationViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/31.
//

import SwiftUI

class NotificationViewModel: ObservableObject {
    var currentCase: notificationCase
    
    init(currentCase: notificationCase) {
        self.currentCase = currentCase
    }
    
}
