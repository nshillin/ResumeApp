//
//  XCUIApplicationExtension.swift
//  ResumeUITests
//
//  Created by Noah Shillington on 2019-07-09.
//  Copyright © 2019 Noah Shillington. All rights reserved.
//

import XCTest

extension XCUIElement {
    func scrollUpToElement(element: XCUIElement) {
        while !element.visible() {
            swipeDown()
        }
    }
    
    func scrollDownToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
