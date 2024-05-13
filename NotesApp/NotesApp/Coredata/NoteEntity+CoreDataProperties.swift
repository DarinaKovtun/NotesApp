//
//  NoteEntity+CoreDataProperties.swift
//  NotesApp
//
//  Created by Darina Kovtun on 13.05.2024.
//
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var date: Date?
    @NSManaged public var imageUrl: URL?

}

extension NoteEntity : Identifiable {

}
