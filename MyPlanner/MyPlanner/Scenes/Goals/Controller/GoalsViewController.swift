//
//  GoalsViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit

class GoalsViewController: BaseViewController {

    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Goals"
        indicator.startAnimating()
        configureTableView()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "text"
        return cell
    }
    
}

extension GoalsViewController: GoalsViewDelegate {
    func dataLoaded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

