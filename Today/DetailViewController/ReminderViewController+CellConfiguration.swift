//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by Olibo moni on 25/10/2023.
//

import UIKit

extension ReminderViewController {
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        return contentConfiguration
    }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        return contentConfiguration
    }
    
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?) -> TextFieldContentView.Configuration {
        var configuration = cell.textFieldConfiguration()
        configuration.text = title
        configuration.onChange = {[weak self] title in
            self?.workingReminder.title = title /// does not prevent deallocation of workingReminder.title by the system runtime. 
        }
        return configuration
    }

    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date) -> DatePickerContentView.Configuration {
        var configuration = cell.datePickerConfiguration()
        configuration.date = date
        configuration.onChange = {[weak self] dueDate in
            self?.workingReminder.dueDate = dueDate
        }
        return configuration
    }
    
    func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?) -> TextViewContentView.Configuration {
        var configuration = cell.textViewConfiguration()
        configuration.text = notes
        configuration.onChange = { [weak self] notes in
            self?.workingReminder.notes = notes 
        }
        return configuration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .date: return reminder.dueDate.dayText
        case .notes: return reminder.notes
        case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title: return reminder.title
        default:
            return nil
        }
    }
    
}

