//
//  ReminderViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit

class ReminderViewController: BaseViewController {

    let tableView = UITableView(frame: .zero)
    let viewModel = ReminderViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Reminder"
        viewModel.delegate = self
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indicator.startAnimating()
        viewModel.getReminders()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reminderCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.reminders[indexPath.row].rTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }
}

extension ReminderViewController: ReminderViewDelegate {
    func dataLoaded() {
        DispatchQueue.main.async {
            //self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }
    
    
}
