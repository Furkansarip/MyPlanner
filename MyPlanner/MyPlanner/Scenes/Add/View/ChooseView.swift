//
//  ChooseView.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 21.06.2023.
//

import UIKit

class ChooseView: UIView {

    let popupView = UIView()
    let goalButton = PlannerButton(type: .custom)
    let testButton = UIButton(type: .system)
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
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "map")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
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
        addSubview(imageView)
        addSubview(goalButton)
        addSubview(reminderButton)
        translatesAutoresizingMaskIntoConstraints = false
        goalButton.translatesAutoresizingMaskIntoConstraints = false
        reminderButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 250),
            widthAnchor.constraint(equalToConstant: 250),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
        
    }
    
    private func configureButtons() {
        goalButton.setTitle("Goal", for: .normal)
        goalButton.titleLabel?.font = ThemeFont.bold(ofSize: 24)
        reminderButton.setTitle("Reminder", for: .normal)
        reminderButton.titleLabel?.font = ThemeFont.bold(ofSize: 24)
        closeButton.setImage(UIImage(named: "close.png"), for: .normal)
        NSLayoutConstraint.activate([
            goalButton.heightAnchor.constraint(equalToConstant: 60),
            goalButton.widthAnchor.constraint(equalToConstant: 160),
            goalButton.topAnchor.constraint(equalTo: topAnchor,constant: 14),
            goalButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            reminderButton.heightAnchor.constraint(equalToConstant: 60),
            reminderButton.widthAnchor.constraint(equalToConstant: 160),
            reminderButton.topAnchor.constraint(equalTo: goalButton.bottomAnchor,constant: 32),
            reminderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
        ])
        popupView.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(popView), for: .touchUpInside)
        goalButton.addTarget(self, action: #selector(pushGoal), for: .touchUpInside)
        reminderButton.addTarget(self, action: #selector(pushReminder), for: .touchUpInside)
    }
    
    @objc func popView() {
        self.removeFromSuperview()
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
