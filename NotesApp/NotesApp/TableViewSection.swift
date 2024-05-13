//
//  TableViewSection.swift
//  NotesApp
//
//  Created by Darina Kovtun on 12.05.2024.
//

import Foundation

protocol TableViewItemProtocol { }

struct TableViewSection {
    var title: String?
    var items: [TableViewItemProtocol]
}
