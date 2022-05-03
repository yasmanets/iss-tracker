//
//  FlightsViewControllerTests.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 3/5/22.
//

import XCTest
@testable import iss_tracker
import CoreLocation

class FlightsViewControllerTests: XCTestCase {
    
    var flightsViewController: FlightsViewController!

    override func setUpWithError() throws {
        self.flightsViewController = UIStoryboard(name: "Flights", bundle: nil).instantiateViewController(withIdentifier: "FlightsViewController") as? FlightsViewController
        guard let _ = flightsViewController else {
            return XCTFail("Failed to instantiate SplashViewController")
        }
        self.flightsViewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        self.flightsViewController = nil
    }

    func testSetupNavigationBar() throws {
        XCTAssertTrue(self.flightsViewController.title == R.string.localizable.flight_list_navigation_title(), "Controller title does not match")
    }
    
    func testcCurrentCoordinates() throws {
        self.flightsViewController.currentCoordinates(coordinates: CLLocationCoordinate2D(latitude: ApiConstants.DEFAULT_LATITUDE, longitude: ApiConstants.DEFAULT_LONGITUDE))
        if let location = self.flightsViewController.currentLocation {
            XCTAssertTrue(location.latitude == Double(ApiConstants.DEFAULT_LATITUDE) && location.longitude == Double(ApiConstants.DEFAULT_LONGITUDE), "Location does not match")
        }
        else {
            XCTFail("Error in obtaining location")
        }
    }

}
