//
//  AddTypeView.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 18.06.2023.
//

import Foundation
import UIKit

final class ChooseViewController: UIViewController {
    let popupView = UIView()
    let goalButton = PlannerButton(type: .system)
    let reminderButton = PlannerButton(type: .system)
    let closeButton = UIButton(type: .custom)
    let navController = UINavigationController()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            goalButton,
            reminderButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureViews()
        configureButtons()
    }
    
    private func configureViews() {
        view.addSubview(popupView)
        popupView.addSubview(stackView)
        popupView.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -72),
            popupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 72),
            popupView.heightAnchor.constraint(equalToConstant: 150),
            
            closeButton.topAnchor.constraint(equalTo: popupView.topAnchor,constant: -25),
            closeButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: 15),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: popupView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 150)
            
        ])
        
    }
    
    private func configureButtons() {
        goalButton.setTitle("Goal", for: .normal)
        reminderButton.setTitle("Reminder", for: .normal)
        closeButton.setImage(UIImage(named: "close.png"), for: .normal)
        goalButton.customizeButton(color: .gray, textColor: .systemGreen)
        reminderButton.customizeButton(color: .gray, textColor: .systemIndigo)
        popupView.backgroundColor = .systemBackground
        popupView.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(popView), for: .allTouchEvents)
        goalButton.addTarget(self, action: #selector(pushAddPage), for: .touchUpInside)
    }
    
    @objc func popView() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func pushAddPage() {
        let addPage = AddViewController()
        navigationController?.pushViewController(addPage, animated: true)
        
    }
}
