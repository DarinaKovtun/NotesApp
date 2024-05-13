//
//  Note.swift
//  NotesApp
//
//  Created by Darina Kovtun on 12.05.2024.
//

import UIKit

struct Note: TableViewItemProtocol {
    enum NoteCategory: String {
        case work = "Work"
        case personal = "Personal"
        case other = "Other"
        
        var color: UIColor {
            switch self {
            case .work:
                return .lightGreen
            case .personal:
                return .lightRed
            case .other:
                return .lightYellow
            }
        }
    }
    
    let title: String
    let description: String?
    let date: Date
    let imageURL: URL?
    let image: Data? = nil
    let category: NoteCategory

}
