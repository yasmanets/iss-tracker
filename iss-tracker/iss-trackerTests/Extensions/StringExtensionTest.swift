//
//  StringExtensionTest.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 2/5/22.
//

import XCTest
@testable import iss_tracker

class StringExtensionTest: XCTestCase {

    let text = "el parking"
        
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func capitalizeFirstLetter() throws {
        let capitalizedText = self.text.capitalizingFirstLetter()
        
        XCTAssertTrue(capitalizedText == "ElParking", "Texts must match")
    }
}
