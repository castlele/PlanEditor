//
//  Keywords.swift
//  PlanEditor
//
//  Created by Nikita Semenov on 07.03.2022.
//

import Foundation

enum Keyword {
    case unnamed
    case named
    case `default`
    case numbered
    case lettered
    case list
    case table
    case updating(every: KeywordDate)
    case till(Date)
    
    static var keywordsList: [String: Keyword] {
        ["UNNAMED": .unnamed, "NAMED": .named,
         "DEFAULT": .default, "NUMBERED": .numbered,
         "LETTERED": .lettered, "LIST": .list, "TABLE": .table,
         "UPDATING_EVERY": .updating(every: .none),
         "TILL": .till(Date())]
    }
}

enum KeywordDate: String, CaseIterable {
    case day, week, month, year, none
}
