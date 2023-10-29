//
//  ReminderStore.swift
//  Today
//
//  Created by Olibo moni on 29/10/2023.
//

import Foundation
import EventKit

final class ReminderStore {
    static let shared = ReminderStore()
    
    private let ekStore = EKEventStore()
    
    var isAvailable: Bool {
        if #available(iOS 17.0, *) {
            EKEventStore.authorizationStatus(for: .reminder) == .fullAccess
        } else {
            // Fallback on earlier versions
            EKEventStore.authorizationStatus(for: .reminder) == .authorized
        }
    }
    
    
}
