//
//  NotificationManager.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/31.
//

import SwiftUI
import NotificationCenter

class NotifiactionManager: ObservableObject {
    
    let notiCenter = UNUserNotificationCenter.current()
    
    @Published var isNotiOn: Bool = UserDefaults.standard.bool(forKey: "hasUserAgreedNoti") {
        didSet {
            /* 알림을 사용할 때 실행, 최초에 request Authorization을 하고
             그 다음부턴 디바이스 설정에서 해당 앱의 알림 승인여부에 따라 다른 액션 */
            if isNotiOn {
                UserDefaults.standard.set(true, forKey: "hasUserAgreedNoti")
                requestNotiAuthorization()
            }
            else {
                // Off Action - 2
                UserDefaults.standard.set(false, forKey: "hasUserAgreedNoti")
                requestNotiAuthorization()
            }
        }
    }
    
    func requestNotiAuthorization() {
        // 노티피케이션 설정을 가져오기
        // 상태에 따라 다른 액션 수행
        notiCenter.getNotificationSettings { settings in
            
            // 승인되어있지 않은 경우 request
            if settings.authorizationStatus != .authorized {
                self.notiCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                    if let error = error {
                        print("Error : \(error.localizedDescription)")
                    }
                    
                    // 노티피케이션 최초 승인
                    if granted {
                        self.addNotification()
                    }
                    // 노티피케이션 최초 거부
                    else {
                        DispatchQueue.main.async {
                            self.isNotiOn = false
                        }
                    }
                }
            }
        }
    }
    
    func addNotification() {
        print("Add Notification")
        let content = UNMutableNotificationContent()
        content.title = "냉장고에 어떤 식재료가 있을까요? 🧐"
        content.body = "냉장고를 확인해보세요"
        content.sound = UNNotificationSound.default
        content.userInfo = ["name" : "SickSangHaeAlert"]
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notiCenter.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification added successfully")
            }
        }
    }
    
    func openSettings() {
       if let bundle = Bundle.main.bundleIdentifier,
          let settings = URL(string: UIApplication.openSettingsURLString + bundle) {
            if UIApplication.shared.canOpenURL(settings) {
               UIApplication.shared.open(settings)
            }
        }
    }
    
    func updateIsNotiOnStatus() {
         notiCenter.getNotificationSettings { settings in
             DispatchQueue.main.async {
                 self.isNotiOn = settings.authorizationStatus == .authorized
             }
         }
     }
}
