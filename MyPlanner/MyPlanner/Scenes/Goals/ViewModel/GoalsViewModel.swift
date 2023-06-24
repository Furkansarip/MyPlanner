//
//  GoalsViewModel.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 24.06.2023.
//

import UIKit

protocol GoalsViewModelProtocol {
    var delegate: GoalsViewDelegate? { get set }
    func getReminders()
    func reminderCount() -> Int
}

protocol GoalsViewDelegate: AnyObject {
    func dataLoaded()
}

final class GoalsViewModel: GoalsViewModelProtocol {
    weak var delegate: GoalsViewDelegate?
    var goals = [Goals]()
    
    func getReminders() {
        goals = GoalsDataManager.shared.getGoals()
        delegate?.dataLoaded()
    }
    
    func reminderCount() -> Int {
        return goals.count
    }
    
}
