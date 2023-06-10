//
//  ReminderViewModel.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 10.06.2023.
//

import Foundation

protocol ReminderViewModelProtocol {
    var delegate: ReminderViewDelegate? { get set }
    func getReminders()
    func reminderCount() -> Int
}

protocol ReminderViewDelegate: AnyObject {
    func dataLoaded()
}

final class ReminderViewModel: ReminderViewModelProtocol {
    var delegate: ReminderViewDelegate?
    var reminders = [Reminders]()
    
    func getReminders() {
        reminders = ReminderDataManager.shared.getReminders()
        delegate?.dataLoaded()
    }
    
    func reminderCount() -> Int {
        return reminders.count
    }
    
}
