//
//  MoodTrackerApp.swift
//  MoodTracker
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import SwiftUI

@main
struct MoodTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
