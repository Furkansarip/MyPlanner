//
//  MainViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Main"
        setupTabs()
    }
    
    private func setupTabs() {
        
        let summaryVC = SummaryViewController()
        let goalsVC = GoalsViewController()
        let reminderVC = ReminderViewController()
        let diaryVC = DiaryViewController()
        
        let tag1 = UINavigationController(rootViewController: summaryVC)
        let tag2 = UINavigationController(rootViewController: goalsVC)
        let tag3 = UINavigationController(rootViewController: reminderVC)
        let tag4 = UINavigationController(rootViewController: diaryVC)
        
        tag1.tabBarItem = UITabBarItem(title: "Summary", image: UIImage(systemName: "chart.pie"), tag: 0)
        tag2.tabBarItem = UITabBarItem(title: "Goals", image: UIImage(systemName: "arrow.triangle.pull"), tag: 1)
        tag3.tabBarItem = UITabBarItem(title: "Reminder", image: UIImage(systemName: "exclamationmark.arrow.circlepath"), tag: 2)
        tag4.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(systemName: "text.book.closed"), tag: 3)
        
        
        setViewControllers([tag1,tag2,tag3,tag4], animated: true)
        
    }
    

    
}
