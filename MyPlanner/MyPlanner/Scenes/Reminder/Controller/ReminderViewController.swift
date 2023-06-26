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
        baseDelegate = self
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
        tableView.register(UINib(nibName: "PlannerCell", bundle: nil), forCellReuseIdentifier: "plannerCell")
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ReminderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reminderCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "plannerCell") as? PlannerCell else { return UITableViewCell() }
        let data = viewModel.reminders[indexPath.row]
        cell.configureReminderCell(reminderModel: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if editingStyle == .delete {
            let data = viewModel.reminders[indexPath.row].objectID
            ReminderDataManager.shared.deleteReminder(objectID: data)
            viewModel.reminders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ReminderViewController: ReminderViewDelegate {
    func dataLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }
}

extension ReminderViewController: BaseDelegate {
    func getView(targetView: ChooseView) {
        view.addSubview(targetView)
        view.bringSubviewToFront(targetView)
        targetView.parentView = self
        NSLayoutConstraint.activate([
            targetView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            targetView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

