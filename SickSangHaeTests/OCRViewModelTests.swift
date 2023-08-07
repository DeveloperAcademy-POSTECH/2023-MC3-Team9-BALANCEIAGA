//
//  OCRViewModel.swift
//  SickSangHaeTests
//
//  Created by CHANG JIN LEE on 2023/08/08.
//

import XCTest
@testable import SickSangHae

class OCRViewModelTests: XCTestCase {

    var ocrViewModel: OCRViewModel!

    override func setUpWithError() throws {
        ocrViewModel = OCRViewModel()
    }

    override func tearDownWithError() throws {
        ocrViewModel = nil
    }

    @MainActor func testRecognizeText() {
        let image = UIImage(named: "OnlineShoppingMall")
        ocrViewModel.recognizeText(image: image!)
    }

    @MainActor func testQueryGPT() {
        let expectation = XCTestExpectation(description: "GPT response received")
        ocrViewModel.queryGPT(prompts: "Your sample prompt", dispatchGroup: <#DispatchGroup#>) { response in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testConvertToDictionary() {
        let jsonText = "{\"key1\": [\"value1\", \"value2\"], \"key2\": [1, 2]}"
        let dictionary = ocrViewModel.convertToDictionary(text: jsonText)
        XCTAssertEqual(dictionary?["key1"] as? [String], ["value1", "value2"])
        XCTAssertEqual(dictionary?["key2"] as? [Int], [1, 2])

    }
}
