//
//  DateProviderTests.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 2/5/22.
//

import XCTest
@testable import iss_tracker

class DateProviderTests: XCTestCase {
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testTimestampToSplitedDate() throws {
        // The date of the interview was 27/04/2022 at 16:30.
        let interviewTimestamp: Double = 1651069800
        let date = DateProvider.timestampToSplitedDate(timestamp: interviewTimestamp)
        
        XCTAssertTrue(date[1] == "27" , "The date of the interview was 27/04/2022 at 16:30.")
        XCTAssertTrue(date[3] == "2022" , "The date of the interview was 27/04/2022 at 16:30.")
        XCTAssertTrue(date[4] == "16:30" , "The date of the interview was 27/04/2022 at 16:30.")
    }
    
    func testSecondsToMinutesSeconds() throws {
        let initSeconds = 1521
        let (minutes, seconds) = DateProvider.secondsToMinutesSeconds(seconds: initSeconds)
        
        XCTAssertTrue(minutes == 25 , "The result should be 25 minutes and 21 seconds")
        XCTAssertTrue(seconds == 21 , "The result should be 25 minutes and 21 seconds")
    }
}
