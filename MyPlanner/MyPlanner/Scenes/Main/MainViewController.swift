//
//  MainViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    let button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tabBar.tintColor = .red
        
        // if you dont have storyboard then uncomment below code
        let tabBar = { () -> CustomizedTabBar in
            let tabBar = CustomizedTabBar()
            tabBar.delegate = self
            tabBar.addSubview(button)
            
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
        title = "Main"
        setupTabs()
        
        self.tabBar.items?[0].imageInsets = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        setupButton()
    }
    
    func setupButton() {
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .regular)
        let symbolImage = UIImage(systemName: "plus.circle", withConfiguration: symbolConfiguration)
        button.tintColor = .systemIndigo
        button.setImage(symbolImage, for: .normal)
        
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -31).isActive = true
       
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
