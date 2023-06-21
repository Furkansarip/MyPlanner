//
//  ChooseView.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 21.06.2023.
//

import UIKit

class ChooseView: UIView {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(popupView)
        popupView.addSubview(stackView)
        addSubview(closeButton)
        translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            widthAnchor.constraint(equalToConstant: 250),
            popupView.centerXAnchor.constraint(equalTo: centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: centerYAnchor),
            popupView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -72),
            popupView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 72),
            popupView.heightAnchor.constraint(equalToConstant: 150),

            closeButton.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
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
        popupView.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        goalButton.addTarget(self, action: #selector(pushAddPage), for: .touchUpInside)
    }
    
    @objc func popView() {
        self.removeFromSuperview()
        print("hello")
    }
    
    @objc func pushAddPage() {
       
        
        
    }
}
