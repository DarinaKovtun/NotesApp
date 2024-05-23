//
//  Note.swift
//  NotesApp
//
//  Created by Darina Kovtun on 12.05.2024.
//

import UIKit

struct Note: TableViewItemProtocol {

    let title: String
    let description: String?
    let date: Date
    let imageURL: URL?
}
