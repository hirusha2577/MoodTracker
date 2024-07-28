//
//  MoodTrackerUITests.swift
//  MoodTrackerUITests
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import XCTest

final class MoodTrackerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMoodPredictionFlow() throws {
        let textField = app.textFields["Enter your thoughts..."]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("I am feeling great today!")
        
        let predictButton = app.buttons["Predict Mood"]
        XCTAssertTrue(predictButton.exists)
        
        predictButton.tap()
        
        let predictedMoodLabel = app.staticTexts["Predicted Mood: Happy"]
        XCTAssertTrue(predictedMoodLabel.waitForExistence(timeout: 5), "Expected to see 'Predicted Mood: Happy'")
    }

    func testNavigateToHistoryView() throws {
        let viewHistoryButton = app.buttons["View Mood History"]
        XCTAssertTrue(viewHistoryButton.exists)
        
        viewHistoryButton.tap()
        
        let historyView = app.navigationBars["Mood History"]
        XCTAssertTrue(historyView.exists, "Expected to navigate to Mood History view")
    }
    
    func testSaveMoodEntry() throws {
        let textField = app.textFields["Enter your thoughts..."]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("I am feeling happy today!")
        
        let predictButton = app.buttons["Predict Mood"]
        XCTAssertTrue(predictButton.exists)
        
        predictButton.tap()
        
        let viewHistoryButton = app.buttons["View Mood History"]
        XCTAssertTrue(viewHistoryButton.exists)
        
        viewHistoryButton.tap()
        
        let moodEntryCell = app.staticTexts["I am feeling happy today!"]
        XCTAssertTrue(moodEntryCell.waitForExistence(timeout: 5), "Expected to see the mood entry in history view")
    }
}
