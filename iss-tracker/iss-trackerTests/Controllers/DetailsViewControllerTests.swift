//
//  DetailsViewControllerTests.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 3/5/22.
//

import XCTest
@testable import iss_tracker

class DetailsViewControllerTests: XCTestCase {

    var detailsViewController: DetailsViewController!
    
    override func setUpWithError() throws {
        self.detailsViewController = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        guard let _ = detailsViewController else {
            return XCTFail("Failed to instantiate SplashViewController")
        }
        self.detailsViewController.location = ApiConstants.DEFAULT_ADDRESS
        self.detailsViewController.flight = Flights(duration: 619, risetime: 1651562743)
        self.detailsViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        self.detailsViewController = nil
    }
    
    func testSetupNavigationBar() throws {
        XCTAssertTrue(self.detailsViewController.title == R.string.localizable.detail_navigation_title(), "Controller title does not match")
    }
    
    func testSetupLocationLabels() throws {
        XCTAssertTrue(self.detailsViewController.locationPrefixLabel.text == R.string.localizable.you_are_in_label(), "Location prefix does not match")
        XCTAssertTrue(self.detailsViewController.locationLabel.text == ApiConstants.DEFAULT_ADDRESS, "Address does not match")
    }
    
    func testSetupSecondsLabelText() throws {
        let currentTimestamp = NSDate().timeIntervalSince1970
        let timestampDiff = Int(self.detailsViewController.flight?.risetime! ?? 0) - Int(currentTimestamp)
        XCTAssertTrue(self.detailsViewController.secondsNumberLabel.text == "\(timestampDiff)", "Secodns does not match")
        XCTAssertTrue(self.detailsViewController.secondsTextLabel.text == R.string.localizable.flights_duration_seconds(), "Secodns does not match")
    }
    
    func testSetupDurationLabelText() throws {
        if let seconds = self.detailsViewController.flight?.duration {
            let (minutes, seconds) = DateProvider.secondsToMinutesSeconds(seconds: seconds)
            XCTAssertTrue(self.detailsViewController.durationLabel.text == R.string.localizable.datails_flight_duration("\(minutes)", "\(seconds)"), "Duration text does not match")
        }
        else {
            XCTFail("Error in obtaining seconds")
        }
    }
}
