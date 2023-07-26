//
//  SickSangHaeApp.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/06.
//

import SwiftUI

@main
struct SickSangHaeApp: App {
    @StateObject private var cameraViewModelShared = CameraViewModel()

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
