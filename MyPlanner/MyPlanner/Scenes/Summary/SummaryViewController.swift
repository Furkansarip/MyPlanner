//
//  SummaryViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 30.05.2023.
//

import UIKit
import Charts
import DGCharts
class SummaryViewController: BaseViewController {
    
    let summaryTableView = UITableView(frame: .zero)
    let testView = UIView(frame: .zero)
    let summaryChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Summary"
        view.backgroundColor = .systemBackground
        summaryChart.delegate = self
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureChart()
    }
    
    func configureChart() {
        summaryChart.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let completedCount = CompletedTasksDataManager.shared.tastCount()
        let activeGoals = GoalsDataManager.shared.goalCount()
        let totalGoals = GoalsDataManager.shared.goalCount() + completedCount
       
        let totalGoal = PieChartDataEntry(value: Double(activeGoals), label: "Active")
        let completedGoal = PieChartDataEntry(value: Double(completedCount), label: "Done")
        let entries = [completedGoal, totalGoal]
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = [NSUIColor.systemIndigo, NSUIColor.systemOrange]
        let data = PieChartData(dataSet: dataSet)
        summaryChart.data = data
        summaryChart.holeColor = .secondarySystemFill
        summaryChart.centerText = "Total Goal \(totalGoals)"
        
        
    }
    
    private func configureTableView() {
        view.addSubview(summaryTableView)
        view.addSubview(summaryChart)
        view.addSubview(testView)
        
        summaryTableView.dataSource = self
        summaryTableView.delegate = self
        summaryTableView.translatesAutoresizingMaskIntoConstraints = false
        testView.translatesAutoresizingMaskIntoConstraints = false
        summaryChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            summaryChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            summaryChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            summaryChart.bottomAnchor.constraint(equalTo: testView.topAnchor),
            
            testView.heightAnchor.constraint(equalToConstant: 300),
            testView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            testView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            testView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension SummaryViewController : UITableViewDelegate, UITableViewDataSource, ChartViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Yaklaşanlar"
        } else {
            return "Hedefler"
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .red
    }
    
}
