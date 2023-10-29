//
//  EKEventStore+AsyncFetch.swift
//  Today
//
//  Created by Olibo moni on 29/10/2023.
//

import Foundation
import EventKit

extension EKEventStore {
    func reminders(matching predicate : NSPredicate) async throws -> [EKReminder] {
        try await withCheckedThrowingContinuation { continuation in
            fetchReminders(matching: predicate) { reminders in
                if let reminders {
                    continuation.resume(returning: reminders)
                } else {
                    continuation.resume(throwing: TodayError.failedReadingReminders)
                }
            }
        }
    }
}

