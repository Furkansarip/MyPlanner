//
//  AddViewModel.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 11.06.2023.
//

import Foundation
import UserNotifications

protocol AddViewModelProtocol {
    func setReminder(targetDate: Date)
}

final class AddViewModel: AddViewModelProtocol {
    func setReminder(targetDate: Date) {
        print("Target Date \(targetDate)")
        NotificationManager.shared.localNotify(title: "Test", body: "Testttttt", targetDate: targetDate)
    }
    
}
