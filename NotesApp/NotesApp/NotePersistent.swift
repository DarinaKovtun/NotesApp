//
//  NotePersistent.swift
//  NotesApp
//
//  Created by Darina Kovtun on 13.05.2024.
//

import Foundation
import CoreData

final class NotePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ note: Note) {
        var entity: NoteEntity?
        if let ent = getEntity(for: note) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "NoteEntity",
                                                               in: context) else { return }
            entity = NoteEntity(entity: description,
                                    insertInto: context)
        }
        
        entity?.title = note.title
        entity?.descriptionText = note.description
        entity?.date = note.date
        entity?.imageUrl = note.imageURL
        
        saveContext()
    }
    
    static func delete(_ note: Note) {
        guard let entity = getEntity(for: note ) else { return }
        context.delete(entity)
        saveContext()
    }
    
    static func fetchAll() -> [Note] {
        let request = NoteEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    
    // MARK: - Private methods
    private static func convert(entities: [NoteEntity]) -> [Note] {
        entities.map {
            let notes =  Note(title: $0.title ?? "",
                              description: $0.descriptionText,
                              date: $0.date ?? Date(),
                              imageURL: $0.imageUrl,
                              category: .personal)
            return notes
        }
    }
    
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"),
                                        object: nil)
    }
    
    private static func getEntity(for note: Note) -> NoteEntity? {
        let request = NoteEntity.fetchRequest()
        let predicate = NSPredicate(format: "date = %@", note.date as NSDate)
        request.predicate = predicate
        
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return nil
        }
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save note error: \(error)")
        }
    }
}
