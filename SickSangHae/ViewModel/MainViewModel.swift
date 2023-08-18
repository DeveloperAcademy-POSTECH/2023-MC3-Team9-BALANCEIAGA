//
//  MainViewModel.swift
//  SickSangHae
//
//  Created by user on 2023/08/18.
//

import Foundation

enum topTabBar {
    case basic
    case longterm
}

enum searchingState {
    case filled
    case notSearching
    case focused
    case searching
}

class MainViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var isFocused: Bool = false
    @Published var selectedTopTabBar: topTabBar = topTabBar.basic
    
    var searchingStatus: searchingState {
        switch (text.isEmpty, isFocused) {
        case (false, true):
            return .searching
        case (true, false):
            return .notSearching
        case (true, true):
            return .focused
        case (false, false):
            return .filled
        }
    }
    
    func changeSelectedTopTabBar(to: topTabBar) {
        self.selectedTopTabBar = to
    }
}
