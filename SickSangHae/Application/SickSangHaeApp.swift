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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        print("Sicksanghae is starting up. This is sent from App Delegate class.")
        FirebaseApp.configure()
        
        return true
    }
}
