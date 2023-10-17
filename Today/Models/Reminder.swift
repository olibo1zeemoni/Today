//
//  Reminder.swift
//  Today
//
//  Created by Olibo moni on 17/10/2023.
//

import Foundation

struct Reminder {
    var title: String
    var date: Date
    var note: String? = nil
    var isComplete: Bool = false
}

#if DEBUG
extension Reminder {

}
#endif
