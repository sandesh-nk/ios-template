//
//  iOS_TemplateUITests.swift
//  iOS-TemplateUITests
//
//  Created by Viranchee on 15/04/21.
//

import XCTest

class iOS_TemplateUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
  
  func testUserSearch() throws {
    
    app.launch()
    app.searchFields["Search track"].tap()
    app.keys["M"].tap()
    app.tables["List of songs"].staticTexts["Monster"].tap()
  }

  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
}
