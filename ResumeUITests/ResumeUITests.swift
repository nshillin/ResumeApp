//
//  ResumeUITests.swift
//  ResumeUITests
//
//  Created by Noah Shillington on 2019-07-09.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import XCTest

class ResumeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        app.launchArguments.append("--uitesting")
        
        app.launch()
    }

    override func tearDown() {
    }
    
    
    func testActivityIndicatorHide() {
        waitForActivityIndicatorToHide()
    }
    
    func waitForActivityIndicatorToHide() {
        let element = app.activityIndicators.firstMatch
        XCTAssert(waitForElementToDisappear(element), "Activity indicator did not finish loading.")
    }
    
    func testTabBarExists() {
        XCTAssert(app.tabBars.buttons["General"].exists)
        XCTAssert(app.tabBars.buttons["Experience"].exists)
    }

    
    func testSafariButtons() {
        waitForActivityIndicatorToHide()
        
        let buttonNames = ["AppStore","LinkedIn","GitHub"]
        
        let doneButton = app.buttons["Done"]

        for name in buttonNames {
            let safariButton = app.buttons[name]
            safariButton.tap()
            XCTAssert(waitForElementToAppear(doneButton), "SafariViewController did not open for \(name) button.")
            doneButton.tap()
        }
    }
    
    func testGoToExperienceTabAndBack() {
        app.tabBars.buttons["Experience"].tap()
        XCTAssert(app.navigationBars["Experience"].exists)
        app.tabBars.buttons["General"].tap()
        XCTAssert(app.otherElements["GeneralNavBar"].exists)
    }

    func testTapCells() {
        app.tabBars.buttons["Experience"].tap()
        let experienceTable = app.tables["ExperienceTable"]
        XCTAssert(experienceTable.exists)
        let firstHeader = experienceTable.otherElements["Education"]
        let doneButton = app.buttons["Done"]
        
        let cellNames = ["0","9","5"]
        for name in cellNames {
            let cell = experienceTable.cells[name]
            experienceTable.scrollDownToElement(element: cell)
            cell.tap()
            XCTAssert(waitForElementToAppear(doneButton), "SafariViewController did not open for \(name) button.")
            doneButton.tap()
            experienceTable.scrollUpToElement(element: firstHeader)
        }
    }
    
    // https://stackoverflow.com/a/42222302
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        return waitForElement(element, toExist: true)
    }
    
    func waitForElementToDisappear(_ element: XCUIElement) -> Bool {
        return waitForElement(element, toExist: false)
    }
    
    func waitForElement(_ element: XCUIElement, toExist:Bool) -> Bool {
        let predicate = NSPredicate(format: "exists == \(toExist)")
        let elementExpectation = expectation(for: predicate, evaluatedWith: element,
                                             handler: nil)
        
        let result = XCTWaiter().wait(for: [elementExpectation], timeout: 5)
        return result == .completed
    }
}
