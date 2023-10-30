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
    
    func requestAccess() async throws {
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .fullAccess:
            return
        case .restricted:
            throw TodayError.accessRestricted
        case .denied:
            throw TodayError.accessDenied
        case .notDetermined:
            if #available(iOS 17.0, *) {
                let accessGranted = try await ekStore.requestFullAccessToReminders()
                guard accessGranted else { throw TodayError.accessDenied}
            } else {
                // Fallback on earlier versions
                let accessGranted = try await ekStore.requestAccess(to: .reminder)
                guard accessGranted else { throw TodayError.accessDenied}
            }
        case .writeOnly:
            throw TodayError.accessRestricted
        @unknown default:
            throw TodayError.unknown
        }
    }
    
    func readAll() async throws -> [Reminder] {
        guard isAvailable else {throw TodayError.accessDenied}
        let predicate = ekStore.predicateForReminders(in: nil)
        let ekReminders = try await  ekStore.reminders(matching: predicate)
        //let reminders: [Reminder] = try ekReminders.compactMap({ try Reminder(with: $0) })
        let reminders: [Reminder] = try ekReminders.compactMap { ekReminder in
            do {
                return try Reminder(with: ekReminder)
            } catch TodayError.failedReadingReminders{
                return nil
            }
        }
        return reminders
    }
    
}
