//
//  MoodHistoryView.swift
//  MoodTracker
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import SwiftUI
import CoreData

struct MoodHistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: MoodEntry.getAllMoodEntries()) private var moodEntries: FetchedResults<MoodEntry>
    
    @State private var showingDeleteAlert = false
    @State private var entryToDelete: MoodEntry?

    var body: some View {
        NavigationView {
            List {
                ForEach(moodEntries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.mood)
                            .font(.headline)
                        Text(entry.note)
                            .font(.subheadline)
                        Text("\(entry.date, formatter: dateFormatter)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            entryToDelete = entry
                            showingDeleteAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                .onDelete(perform: deleteMoodEntry)
            }
            .navigationTitle("Mood History")
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete Entry"),
                    message: Text("Are you sure you want to delete this mood entry?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let entry = entryToDelete {
                            delete(entry: entry)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func deleteMoodEntry(at offsets: IndexSet) {
        offsets.map { moodEntries[$0] }.forEach { entry in
            viewContext.delete(entry)
        }
        saveContext()
    }
    
    private func delete(entry: MoodEntry) {
        viewContext.delete(entry)
        saveContext()
        entryToDelete = nil  // Reset the entry to delete after deletion
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Handle the error appropriately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()
