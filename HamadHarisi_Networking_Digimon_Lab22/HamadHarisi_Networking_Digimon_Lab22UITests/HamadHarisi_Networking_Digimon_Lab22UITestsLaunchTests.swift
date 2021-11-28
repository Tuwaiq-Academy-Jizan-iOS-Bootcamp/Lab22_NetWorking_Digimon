//
//  HamadHarisi_Networking_Digimon_Lab22UITestsLaunchTests.swift
//  HamadHarisi_Networking_Digimon_Lab22UITests
//
//  Created by حمد الحريصي on 24/11/2021.
//

import XCTest

class HamadHarisi_Networking_Digimon_Lab22UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
