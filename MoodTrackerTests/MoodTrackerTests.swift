//
//  MoodTrackerTests.swift
//  MoodTrackerTests
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import XCTest
@testable import MoodTracker

final class MoodTrackerTests: XCTestCase {
    
    var moodService: MoodPredictionService!

    override func setUpWithError() throws {
        moodService = MoodPredictionService()
    }

    override func tearDownWithError() throws {
        moodService = nil
    }
    
    func testPredictMoodHappy() throws {
        let moodText = "I am feeling great today!"
        let prediction = moodService.predictMood(from: moodText)
        XCTAssertEqual(prediction, "Happy", "Expected mood to be Happy")
    }

    func testPredictMoodSad() throws {
        let moodText = "This is the worst day ever"
        let prediction = moodService.predictMood(from: moodText)
        XCTAssertEqual(prediction, "Sad", "Expected mood to be Sad")
    }

    func testPredictMoodAngry() throws {
        let moodText = "I am so angry right now!"
        let prediction = moodService.predictMood(from: moodText)
        XCTAssertEqual(prediction, "Angry", "Expected mood to be Angry")
    }

    func testPredictMoodRelaxed() throws {
        let moodText = "I feel so relaxed and calm."
        let prediction = moodService.predictMood(from: moodText)
        XCTAssertEqual(prediction, "Relaxed", "Expected mood to be Relaxed")
    }

}
