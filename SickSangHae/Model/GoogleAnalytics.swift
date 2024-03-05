//
//  Analytics.swift
//  SickSangHae
//
//  Created by user on 3/5/24.
//
import FirebaseAnalytics
import Foundation
import SwiftUI

protocol GASendable: RawRepresentable {
    func value() -> String?
}

extension GASendable {
    func value() -> String? {
        if let sendableString = self.rawValue as? String {
            return sendableString
        } else {
            return nil
        }
    }
}

class Analyzer {
//    static func sendGA(_ attribute: any GASendable) { //MARK: 함수명 변경
//        if let sendableString = attribute.value() {
//            Analytics.logEvent(sendableString, parameters: nil)
//        }
//    }
    
    static func sendGA<T: GASendable>(_ attribute: T) { //MARK: 함수명 변경
        if let sendableString = attribute.value() {
            Analytics.logEvent(sendableString, parameters: nil)
        }
    }
}

// MARK: String(Struct타입)과 GASendable(Protocol)을 한번에 묶어서 표현이 안될까?

enum MainViewEvents:  String, GASendable {
    case appear = "MainView"
    case basicSave = "일반보관"
    case longtermSave = "장기보관"
    case searchBar = "검색창"
    case filter = "최신순필터"
}

enum HistoryViewEvents: String, GASendable {
    case appear = "HistoryView"
    case eatenTab = "먹었어요_탭"
    case rottenTab = "상했어요_탭"
    case deleteButton = "삭제_버튼"
    case restoreButton = "복구하기_버튼"
}

enum ChartViewEvents: String, GASendable {
    case appear = "차트뷰"
}

enum SettingViewEvents: String, GASendable {
    case appear = "설정뷰"
    case toSystemSetting = "시스템_설정_이동_버튼"
    case expireNotificationToggle = "식료품_경과일_알림_토글"
    case cleanNotificationToggle = "식재료_정리_알림_토글"
    case chartNotificationToggle = "식통계_알림_토글"
}



enum TabBarEvents: String, GASendable {
    case mainViewTab = "메인뷰_탭_버튼"
    case historyTab = "식기록_탭_버튼"
    case chartsTab = "식통계_탭_버튼"
    case settingsTab = "설정_탭_버튼"
    case scanButton = "스캔_버튼_탭"
}

enum CameraViewEvents: String, GASendable {
    case appear = "카메라_뷰"
    case closeButton = "카메라_뷰_취소_버튼"
    case galleryButton = "갤러리_버튼"
    case captureButton = "찍기_버튼"
    case flashButton = "플래쉬_버튼"
    case selfAddButton = "CameraView_직접_추가하기_버튼"
}

enum GetScreenShotViewEvents: String, GASendable {
    case appear = "스크린샷_뷰"
    case backButton = "GetScreenShotView_뒤로가기_버튼"
    case registerButton = "GetScreenShotView_등록하기_버튼"
}

enum OCRViewEvents: String, GASendable {
    case appear = "OCR_뷰"
}

enum OCRItemCheckViewEvents: String, GASendable {
    case appear = "OCR_확인_뷰"
    case cancelButton = "OCRItemCheckView_취소_버튼"
    case editButton = "OCRItemCheckView_편집_버튼"
    case registerButton = "OCRItemCheckView_등록하기_버튼"
}

enum OCRUpdateItemViewEvents: String, GASendable {
    case appear = "OCR_수정_뷰"
    case editButton = "OCRUpdateItemView_편집_버튼"
    case addItemButton = "OCRUpdateItemView_아이템_등록버튼"
    case backButton = "OCRUpdateItemView_뒤로가기_버튼"
    case xButton = "OCRUpdateItemView_종료_버튼"
}

enum ItemBlockViewEvents: String, GASendable {
    case appear = "아이템_블록_뷰"
    case editItemButton = "ItemBlockView_아이템_수정"
    case deleteItemButton = "ItemBlockView_아이템_삭제"
    
    case modalAppear = "품목_수정_모달"
    case cancelButton = "품목_수정_모달_취소_버튼"
    case editCompleteButton = "품목_수정_모달_완료_버튼"
    case nameChange = "품목_수정_이름_변경"
    case xmarkButton = "품목_수정_xmark_버튼"
    case priceChange = "품목_수정_금액_변경"
}

enum DirectUpdateItemViewEvents: String, GASendable {
    case appear = "직접_추가_뷰"
    case backButton = "DirectUpdateItemView_뒤로가기_버튼"
    case xmarkButton = "DirectUpdateItemView_xmark_버튼"
    case nextButton = "DirectUpdateItemView_다음_버튼"
    case addItemButton = "DirectUpdateItemView_품목_추가하기_버튼"
}

enum DirectItemCheckViewEvents: String, GASendable {
    case appear = "직접_추가_아이템_확인_뷰"
    case backButton = "DirectItemCheckView_뒤로가기_버튼"
    case xmarkButton = "DirectItemCheckView_xmark_버튼"
    case registerButton = "DirectItemCheckView_등록하기_버튼"
}

enum RegisterCompleteViewEvents: String, GASendable {
    case appear = "등록_완료_뷰"
    case closeButton = "RegisterCompleteView_닫기_버튼"
}
