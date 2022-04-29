//
//  SplashViewControllerTests.swift
//  iss-trackerTests
//
//  Created by Yaser El Dabete Arribas on 29/4/22.
//

import XCTest
@testable import iss_tracker

class SplashViewControllerTests: XCTestCase {

    var splashViewController: SplashViewController!
        
    override func setUp() {
        self.splashViewController = SplashViewController()
        guard let _ = splashViewController else {
            return XCTFail("Failed to instantiate SplashViewController")
        }
        super.setUp()
    }

    override func tearDown() {
        self.splashViewController = nil
        super.tearDown()
    }

    func navigateToFlightsList() throws {
        let identifiers = self.getSeguesIdentifier()
        
        XCTAssertEqual(identifiers.count, 1, "Segue count should be one.")
        XCTAssertTrue(identifiers.contains("FlightsSegue"), "Segue FlightsSegue should exist.")
    }
    
    // MARK: - Function to get segues identifier
    func getSeguesIdentifier() -> [String] {
        return (self.splashViewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
    }
}
