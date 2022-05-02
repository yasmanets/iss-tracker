//
//  StringExtensionTest.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 2/5/22.
//

import XCTest
@testable import iss_tracker

class StringExtensionTest: XCTestCase {
    
    var text = ""
    
    override func setUpWithError() throws {
        self.text = "elParking"
    }

    override func tearDownWithError() throws {
        self.text = ""
    }

    func testCapitalizeFirstLetter() throws {
        let capitalizedText = self.text.capitalizingFirstLetter()
        
        XCTAssertTrue(capitalizedText == "ElParking", "Texts must match")
    }
}
