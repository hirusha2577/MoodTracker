
import CreateML
import Foundation

// Load the dataset
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/hirusharavishan/4th year/MAD/test02-mytest/mood_dataset.csv"))

// Split the data into training and testing sets
let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 0)

// Create the text classifier
let moodClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "label")

// Evaluate the model
let evaluationMetrics = moodClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "label")
let accuracy = (1.0 - evaluationMetrics.classificationError) * 100
print("Accuracy: \(accuracy)%")

// Save the model
let modelMetadata = MLModelMetadata(author: "Hirusha Ravishan",
                                    shortDescription: "A model to classify mood based on text",
                                    version: "1.0")
try moodClassifier.write(to: URL(fileURLWithPath: "/Users/hirusharavishan/4th year/MAD/test02-mytest/MoodClassifier.mlmodel"), metadata: modelMetadata)
