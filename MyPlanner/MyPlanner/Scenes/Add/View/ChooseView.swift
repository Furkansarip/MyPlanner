//
//  ChooseView.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 21.06.2023.
//

import UIKit

class ChooseView: UIView {

    let popupView = UIView()
    let goalButton = PlannerButton()
    let reminderButton = PlannerButton()
    let closeButton = UIButton(type: .custom)
    var parentView: UIViewController? = nil
    let dividerView = UIView()
    let addPage = AddViewController()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            goalButton,
            dividerView,
            reminderButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
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
        dividerView.backgroundColor = .gray
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 200),
            widthAnchor.constraint(equalToConstant: 250),
            dividerView.widthAnchor.constraint(equalToConstant: 5),
            goalButton.heightAnchor.constraint(equalToConstant: 60),
            reminderButton.heightAnchor.constraint(equalToConstant: 60),
            
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
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
            
        ])
        
    }
    
    private func configureButtons() {
       
        goalButton.setImage(UIImage(named: "arrow2.png"), for: .normal)
        goalButton.alignImageAndTitleVertically(padding: 5)
        goalButton.setTitle("Goal", for: .normal)
        
        reminderButton.setTitle("Reminder", for: .normal)
        reminderButton.setImage(UIImage(named: "colorfulClock.png"), for: .normal)
        
        closeButton.setImage(UIImage(named: "close.png"), for: .normal)
        
        popupView.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        goalButton.addTarget(self, action: #selector(pushGoal), for: .touchUpInside)
        reminderButton.addTarget(self, action: #selector(pushReminder), for: .touchUpInside)
    }
    
    @objc func popView() {
        self.removeFromSuperview()
        print("hello")
    }
    
    @objc func pushGoal() {
        addPage.viewModel.isReminderPage = false
        parentView?.navigationController?.pushViewController(addPage, animated: false)
        self.removeFromSuperview()
        
    }
    
    @objc func pushReminder() {
        addPage.viewModel.isReminderPage = true
        parentView?.navigationController?.pushViewController(addPage, animated: false)
        self.removeFromSuperview()
        
    }
}
