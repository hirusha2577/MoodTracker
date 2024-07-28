//
//  MoodPredictionService.swift
//  MoodTracker
//
//  Created by Hirusha Ravishan on 2024-06-12.
//

import Foundation
import CoreML

class MoodPredictionService {
    private let model: MoodClassifier
    
    init() {
        guard let model = try? MoodClassifier(configuration: .init()) else {
            fatalError("Failed to load CoreML model.")
        }
        self.model = model
    }
    
    func predictMood(from text: String) -> String? {
        do {
            let input = MoodClassifierInput(text: text)
            let prediction = try model.prediction(input: input)
            return prediction.label
        } catch {
            print("Prediction error: \(error)")
            return nil
        }
    }
}

