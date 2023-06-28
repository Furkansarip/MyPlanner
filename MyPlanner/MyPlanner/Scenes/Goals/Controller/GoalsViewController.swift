//
//  GoalsViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit

class GoalsViewController: BaseViewController {
    
    let tableView = UITableView()
    let viewModel = GoalsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Your Goals"
        indicator.startAnimating()
        viewModel.delegate = self
        baseDelegate = self
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getGoals()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(indicator)
        tableView.register(UINib(nibName: "PlannerCell", bundle: nil), forCellReuseIdentifier: "plannerCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goalsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "plannerCell") as? PlannerCell else { return UITableViewCell() }
        let data = viewModel.goals[indexPath.row]
        cell.configureGoalCell(goalModel: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { contextualAction, view, boolValue in
            self.showAlert(title: "Congratzz!", message: "You are a focused person...")
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
            let data = self.viewModel.goals[indexPath.row].objectID
            GoalsDataManager.shared.deleteGoal(objectID: data)
            self.viewModel.goals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        doneAction.backgroundColor = .systemGreen
        let swipeActions = UISwipeActionsConfiguration(actions: [doneAction, deleteAction])
        swipeActions.performsFirstActionWithFullSwipe = false
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension GoalsViewController: GoalsViewDelegate {
    func dataLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

extension GoalsViewController: BaseDelegate {
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
