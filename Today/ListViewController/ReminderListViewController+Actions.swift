//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Olibo moni on 21/10/2023.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
        //collectionView.reloadData()
    }
}
