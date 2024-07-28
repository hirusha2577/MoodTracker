//
//  MoodEntry.swift
//  MoodTracker
//
//  Created by Hirusha Ravishan on 2024-06-11.
//

import CoreData

@objc(MoodEntry)
public class MoodEntry: NSManagedObject, Identifiable {
    @NSManaged public var date: Date
    @NSManaged public var mood: String
    @NSManaged public var note: String
}

extension MoodEntry {
    static func getAllMoodEntries() -> NSFetchRequest<MoodEntry> {
        let request: NSFetchRequest<MoodEntry> = MoodEntry.fetchRequest() as! NSFetchRequest<MoodEntry>
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        return request
    }
}
