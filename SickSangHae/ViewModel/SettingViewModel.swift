//
//  SettingViewModel.swift
//  SickSangHae
//
//  Created by 최효원 on 2023/07/31.
//

import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var isOnToggle = false
    
    var settingListItems: [SettingListItem] = [
        SettingListItem(title: "앱 푸시 알림", isSubTitle: false, subTitle: nil, isToggle: false, buttonTitle: "설정"),
        SettingListItem(title: "식료품 경과일 알림", isSubTitle: true, subTitle: "설정한 기준일이 지난 경우 알려드려요", isToggle: true, buttonTitle: ""),
        SettingListItem(title: "빨리 먹어야 해요", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "2일"),
        SettingListItem(title: "기본", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "1주"),
        SettingListItem(title: "장기보관", isSubTitle: false, subTitle: "", isToggle: false, buttonTitle: "1달"),
        SettingListItem(title: "식재료 정리 알림", isSubTitle: true , subTitle: "주기적인 냉장고 정리를 위해 알려드려요", isToggle: true, buttonTitle: ""),
        SettingListItem(title: "식통계 알림", isSubTitle: true, subTitle: "매월 1일 통계를 확인하도록 알려드려요.", isToggle: true, buttonTitle: "")
    ]
    
    // 해당 아이템의 제목이 "앱 푸시 알림" 또는 "빨리 먹어야 해요"일 때에만 true 반환
    func isShowListSection(for item: SettingListItem) -> Bool {
        return item.title == "앱 푸시 알림" || item.title == "장기보관"
    }
}
