//
//  GoalsViewModel.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 24.06.2023.
//

import UIKit

protocol GoalsViewModelProtocol {
    var delegate: GoalsViewDelegate? { get set }
    func getGoals()
    func goalsCount() -> Int
}

protocol GoalsViewDelegate: AnyObject {
    func dataLoaded()
}

final class GoalsViewModel: GoalsViewModelProtocol {
    weak var delegate: GoalsViewDelegate?
    var goals = [Goals]()
    
    func getGoals() {
        goals = GoalsDataManager.shared.getGoals()
        delegate?.dataLoaded()
    }
    
    func goalsCount() -> Int {
        return goals.count
    }
    
}
