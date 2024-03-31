//
//  SickSangHaeApp.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import Firebase
import SwiftUI

@main
struct SickSangHaeApp: App {
    @StateObject private var cameraViewModelShared = CameraViewModel()
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
        let appState = AppState()
            TabBarView(appState: appState)
                .environmentObject(appState)
                .environmentObject(cameraViewModelShared)
        }
    }
}

struct ContentView: View {
   var body: some View {
       Text("Hello")
   }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        print("Sicksanghae is starting up. This is sent from App Delegate class.")
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        
        FirebaseApp.configure()
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let name = userInfo["name"] as? String {
            if name == "SickSangHaeAlert" {
//                print("Entered From Clicking Notification")
                
                Analyzer.sendGA(AlertClickEvent.alert)
            }
        }
    }
}


struct TestView: View {
    let notimanager = NotifiactionManager()
    var body: some View {
        Button("Press to add Notification") {
            notimanager.addNotification()
        }
    }
}
