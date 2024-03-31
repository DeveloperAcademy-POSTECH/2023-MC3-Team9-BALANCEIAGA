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
            print(sendableString)
            return sendableString
        } else {
            return nil
        }
    }
}

class Analyzer {
    static func sendGA<T: GASendable>(_ attribute: T) { //MARK: 함수명 변경
        if let sendableString = attribute.value() {
            Analytics.logEvent(
                sendableString,
                parameters:
                    [
                        AnalyticsParameterScreenName: sendableString,
                            AnalyticsParameterScreenClass: sendableString
                    ])
            // 화면이름, nil
        }
    }
}

// 메인뷰 등장 12 [nil]
// 메인뷰 카메라 버튼 10 [nil]
// ... [nil]


// MARK: 현재 네이밍 규칙
// ViewID_ActionName_KRName
// e.g) A11(ViewID)_ShortTermTapped(ActionName)_일반보관누름(KRName)

// 원래는 ViewID_ButtonID_한국이름 -> 근데 아직 버튼 이름이 안정해져서 일단은 제외하고?

// 궁금한점 1. 뒤에 KRName부분이 길어지면 띄어쓰기를 안해서 가독성이 안좋아짐. 띄어쓰기를 해야하는지?

// e.g)
// T11_EditViewModalTapped_편집하기모달띄우는버튼탭 (X)
// T11_EditViewModalTapped_편집하기_모달_띄우는_버튼_탭 (O)

// 궁금한점 2. 피그마에는 플로우대로 구분되어 있는데, 실제 프로젝트에서는 각 뷰별로 파일이 구분되어 있음. 이때 ViewID를 어떻게 달아야하는지?
// e.g) 피그마에는 카메라로 등록하는 부분이 다 B시리즈로 되어있음. 근데


// 궁3. 탭바

enum MainViewEvents:  String, GASendable {
//    case appear = "A11_Default_메인뷰"
//    case basicSave = "A11_ShortTermTapped_일반보관_탭_누름"
//    case longtermSave = "A11_LongTermTapped_장기보관_탭_누름"
//    case searchBar = "A11_SearchbarTapped_검색창_탭_누름"
//    case filter = "A11_FilterTapped_최신순필터_누름"
    
    // Ver. Moca
    case appear = "A11_MainDefault_메인뷰"
    case basicTerm = "A11_MainBasicTermTab_일반보관_탭_누름"
    case longTerm = "A11_MainLongTermTab_장기보관_탭_누름"
    case searchBar = "A11_MainSearchBar_검색창_탭_누름"
    case filter = "A11_MainFilter_최신순필터_누름"
}

enum HistoryViewEvents: String, GASendable {
//    case appear = "HistoryView"
//    case eatenTab = "먹었어요_탭"
//    case rottenTab = "상했어요_탭"
//    case deleteButton = "삭제_버튼"
//    case restoreButton = "복구하기_버튼"
    case appear = "D11_HistoryDefault_히스토리뷰"
    case eatenTab = "D11_HistoryEaten_먹었어요_버튼_탭"
    case rottenTab = "D11_HistoryRotten_상했어요_버튼_탭"
    case deleteButton = "D11_HistoryDelete_삭제_버튼_탭"
    case restoreButton = "D11_HistoryRestore_복구_버튼_탭"
}

enum ChartViewEvents: String, GASendable {
    case appear = "E11_ChartDefault_차트뷰"
}

enum SettingViewEvents: String, GASendable {
//    case appear = "설정뷰"
//    case toSystemSetting = "시스템_설정_이동_버튼"
//    case expireNotificationToggle = "식료품_경과일_알림_토글"
//    case cleanNotificationToggle = "식재료_정리_알림_토글"
//    case chartNotificationToggle = "식통계_알림_토글"
    case appear = "F11_SettingDefault_설정뷰"
    case toSystemSetting = "F11_SettingSystemSetting_시스템설정_이동_버튼"
    case expireNotificationToggle = "F11_SettingExpirationNotiToggle_식료품_경과일_알림_토글"
    case cleanNotificationToggle = "F11_SettingCleanNotiToggle_식재료정리_알림_토글"
    case chartNotificationToggle = "F11_SettingChartNotiToggle_식통계_알림_토글"
}

enum TabBarEvents: String, GASendable {
    case scanButton = "TB0_TabBarScanButton_스캔_버튼_탭"
    case mainViewTab = "TB1_TabBarMainViewTab_메인뷰_탭_버튼"
    case historyTab = "TB2_TabBarHistoryTab_식기록_탭_버튼"
    case chartsTab = "TB3_ChartTab_식통계_탭_버튼"
    case settingsTab = "TB4_TabBarSettingsTab_설정_탭_버튼"
}

enum CameraViewEvents: String, GASendable {
//    case appear = "카메라_뷰"
//    case closeButton = "카메라_뷰_취소_버튼"
//    case galleryButton = "갤러리_버튼"
//    case captureButton = "찍기_버튼"
//    case flashButton = "플래쉬_버튼"
//    case selfAddButton = "CameraView_직접_추가하기_버튼"
    case appear = "B11_CameraDefault_카메라뷰"
    case closeButton = "B11_CameraClose_취소_버튼"
    case galleryButton = "B11_CameraGallery_갤러리_버튼"
    case captureButton = "B11_CameraCapture_찍기_버튼"
    case flashButton = "B11_CameraFlash_플래시_버튼"
    case selfAddButton = "B11_CameraSelfAdd_직접_추가_버튼"
}

//MARK: 이 부분 피그마에서 보면 전부 다 B시리즈로 퉁쳐져있음
enum GetScreenShotViewEvents: String, GASendable {
//    case appear = "스크린샷_뷰"
//    case backButton = "GetScreenShotView_뒤로가기_버튼"
//    case registerButton = "GetScreenShotView_등록하기_버튼"
    case appear = "B12_ScanDefault_스크린샷뷰"
    case backButton = "B12_ScanBack_뒤로가기_버튼"
    case registerButton = "B12_ScanRegister_등록하기_버튼"
}

enum OCRViewEvents: String, GASendable {
    case appear = "B12_OCRViewDefault_OCR뷰"
}

enum OCRItemCheckViewEvents: String, GASendable {
    case appear = "B13_CartDefault_OCR_확인_뷰"
    case cancelButton = "B13_CartCancel_취소_버튼"
    case editButton = "B13_CartEditButton_편집_버튼"
    case registerButton = "B13_CartRegisterButton_등록하기_버튼"
}

enum OCRUpdateItemViewEvents: String, GASendable {
    case appear = "B14_CartEditDefault_OCR편집뷰"
    case editButton = "B14_CartEditEdit_편집_버튼"
    case addItemButton = "B14_CartEditRegister_아이템_등록_버튼"
    case backButton = "B14_CartEditBack_뒤로가기_버튼"
    case xButton = "B14_CartEditXmark_종료_버튼"
}

enum ItemBlockViewEvents: String, GASendable {
    case appear = "B14_ItemBlockDefault_아이템블록뷰"
    case editItemButton = "B14_ItemBlockEdit_아이템_수정"
    case deleteItemButton = "B14_ItemBlockDelete_아이템_삭제"
    
    
    case modalAppear = "B17_EditModalDefault_품목_수정_모달"
    case cancelButton = "B17_EditModalCancel_취소_버튼"
    case editCompleteButton = "B17_EditModalComplete_완료_버튼"
    case nameChange = "B17_EditModalNameTextField_품목명_텍스트필드"
    case xmarkButton = "B17_EditModalXmark_xmark_버튼"
    case priceChange = "B17_EditModalPriceTextField_구매금액_텍스트필드"
}

enum DirectUpdateItemViewEvents: String, GASendable {
    case appear = "B31_ManualDefault_직접추가_뷰"
    case backButton = "B31_ManualBack_뒤로가기_버튼"
    case xmarkButton = "B31_ManualXmark_xmark_버튼"
    case nextButton = "B31_ManualNext_다음_버튼"
    case addItemButton = "B31_ManualAddItem_품목_추가하기_버튼"
}

enum DirectItemCheckViewEvents: String, GASendable {
    case appear = "B32_ManualCartDefault_직접_추가_아이템_확인_뷰"
    case backButton = "B32_ManualCartBack_뒤로가기"
    case xmarkButton = "B32_ManualCartXmark_x버튼"
    case registerButton = "B32_ManualCartRegister_등록하기"
}

enum RegisterCompleteViewEvents: String, GASendable {
    case appear = "B19_RegisterDoneDefault_등록완료뷰"
    case closeButton = "B19_RegisterDoneClose_닫기"
}

enum ItemDetailViewEvents: String, GASendable {
    case appear = "C11_ItemDetailDefault_아이템_디테일뷰"
    case back = "C11_ItemDetailBack_뒤로가기"
    case eaten = "C11_ItemDetailEaten_먹었어요"
    case rotten = "C11_ItemDetailRotten_상했어요"
    case basicFridge = "C11_ItemDetailBasic_냉장고_기본"
    case fastEatFridge = "C11_ItemDetailFastEat_냉장고_빨리_먹어야_해요"
    case slowEatFridge = "C11_ItemDetailSlowEat_냉장고_천천히_먹어도_돼요"
    case edit = "C11_ItemDetailEdit_편집"
    case delete = "C11_ItemDetailDelete_삭제"
    case cancelDelete = "C11_ItemDetailCancelDelete_삭제_취소"
}


enum EditItemDetailViewEvents: String, GASendable {
    case appear = "C21_ItemEditDefault_아이템_수정뷰"
    case cancel = "C21_ItemEditCancel_취소"
    case complete = "C21_ItemEditComplete_완료"
    case iconButton = "C21_ItemEditIcon_아이콘_버튼"
    case itemName = "C21_ItemEditItemName_품목명_텍스트필드"
    case purchaseDate = "C21_ItemEditPurchaseDate_구매일_텍스트필드"
    case purchasePrice = "C21_ItemEditPurchase"
}

enum EditIconDetailViewEvents: String, GASendable {
    case appear = "C31_IconViewDefault_아이콘뷰"
    case cancel = "C31_IconViewCancel_취소"
    case complete = "C31_IconViewCancel_완료"
    case xmark = "C31_IconViewXMark_x버튼"
    case iconItem = "C31_IconViewIconItem_아이콘"
}

enum AlertClickEvent: String, GASendable {
    case alert = "AL_AlertDefault_알림클릭"
}
