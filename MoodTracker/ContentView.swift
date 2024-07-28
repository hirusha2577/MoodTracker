//
//  ContentView.swift
//  MoodTracker
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import SwiftUI
import CoreData
import Vision

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedMood = "Happy"
    @State private var note = ""
    @State private var isShowingHistory = false
    @State private var showAlert = false
    
    let moods = ["Happy", "Sad", "Angry", "Relaxed"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Picker("Select Mood", selection: $selectedMood) {
                    ForEach(moods, id: \.self) { mood in
                            Text(mood)
                                .padding()
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                TextField("Enter note", text: $note, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                HStack(spacing: 20) {
                    Button(action: addMoodEntry) {
                        Text("Save Mood")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                
                    Button(action: { isShowingHistory.toggle() }) {
                        Text("View History")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
                .padding()
                
                Spacer()
           
                
            }
            .navigationTitle("Mood Tracker")
            .sheet(isPresented: $isShowingHistory) {
                MoodHistoryView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .onChange(of: note, perform: { value in
                predictMood(from: value)
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Success"),
                    message: Text("Mood entry saved successfully."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    private func addMoodEntry() {
        withAnimation {
            let newEntry = MoodEntry(context: viewContext)
            newEntry.date = Date()
            newEntry.mood = selectedMood
            newEntry.note = note
            
            do {
                try viewContext.save()
                showAlert = true
                note = ""
            } catch {
                // Handle error appropriately
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    private func predictMood(from text: String) {
        let moodService = MoodPredictionService()
        DispatchQueue.main.async {
            self.selectedMood = moodService.predictMood(from: text)!
        }
    }

}
