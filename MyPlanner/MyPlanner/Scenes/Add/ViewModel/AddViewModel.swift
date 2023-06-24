//
//  AddViewModel.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 11.06.2023.
//

import Foundation
import UserNotifications
import UIKit

protocol AddViewModelProtocol {
    var delegate: AddViewModelDelegate? { get set }
    func loadUI(view: UIView)
    func configurePicker(delegate: UIViewController)
    func pickerDoneAction()
    func setReminder(title: String, body:String, targetDate: Date)
    func typeCount() -> Int
    func reminderCount() -> Int
}

protocol AddViewModelDelegate : AnyObject {
    func popController() 
    func editingDone()
}

final class AddViewModel: AddViewModelProtocol {
    
    weak var delegate: AddViewModelDelegate?
    var doneButton = UIBarButtonItem()
    let typeArray = ["Choose 🕹","Money 💰","Health 🩺","Life 🏡"]
    let reminderArray = ["15 Min","30 Min","1 Hour"]
    let titleTextField = PlannerTextField()
    let dateTextField = PlannerTextField()
    let typeTextField = PlannerTextField()
    let descriptionTextField = PlannerTextView()
    let reminderTypeTextField = PlannerTextField()
    let addButton = UIButton(type: .system)
    let dateFormatter = DateFormatter()
    let typePicker = UIPickerView()
    let reminderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let isReminderPage = false
    private lazy var stackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [
      titleTextField,
      dateTextField,
      reminderTypeTextField,
      typeTextField,
      descriptionTextField
      ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    func loadUI(view: UIView) {
        view.addSubview(stackView)
        view.addSubview(addButton)
        titleTextField.placeholder = "Title"
        typeTextField.placeholder = "Type"
        dateTextField.placeholder = "Date"
        reminderTypeTextField.placeholder = "Reminder Time"
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        pickerDoneAction()
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            typeTextField.heightAnchor.constraint(equalToConstant: 35),
            dateTextField.heightAnchor.constraint(equalToConstant: 35),
            reminderTypeTextField.heightAnchor.constraint(equalToConstant: 35),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -padding),
            
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -padding)
            
        ])
    }
    
    func setReminder(title: String, body:String, targetDate: Date) {
        print("Title:\(title)")
        print("body :\(body)")
        print("targetdate:\(targetDate)")
        NotificationManager.shared.localNotify(title: title, body: body, targetDate: targetDate)
    }
    
    func typeCount() -> Int {
        return typeArray.count
    }
    
    func reminderCount() -> Int {
        return reminderArray.count
    }
    
    @objc func addButtonAction() {
        if isReminderPage {
            ReminderDataManager.shared.saveReminder(title: titleTextField.text!,
                                                    date: dateTextField.text!,
                                                    reminderType: reminderTypeTextField.text!,
                                                    type: typeTextField.text!,
                                                    description: descriptionTextField.text!)
            let date = dateTextField.text
            guard let convertedDate = date?.toDate() else { return }
            setReminder(title: titleTextField.text!, body: "description", targetDate: convertedDate)
            delegate?.popController()
        } else {
            GoalsDataManager.shared.saveGoal(title: titleTextField.text!,
                                             date: dateTextField.text!,
                                             type: typeTextField.text!,
                                             description: descriptionTextField.text!)
            let date = dateTextField.text
            guard let convertedDate = date?.toDate() else { return }
            setReminder(title: "Goal", body: "Challenge Completed!", targetDate: convertedDate)
            delegate?.popController()
        }
        
    }
    
    func configurePicker(delegate: UIViewController) {
        typeTextField.inputView = typePicker
        typePicker.delegate = delegate as? UIPickerViewDelegate
        typePicker.dataSource = delegate as? UIPickerViewDataSource
        
        dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "tr") as Locale
        datePicker.timeZone = TimeZone.current
        
        reminderTypeTextField.inputView = reminderPicker
        reminderPicker.delegate = delegate as? UIPickerViewDelegate
        reminderPicker.dataSource = delegate as? UIPickerViewDataSource
        
    }
    
    func pickerDoneAction() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        //toolbar.setItems([doneButton], animated: false)
        
        toolbar.items = [
                    UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                    doneButton
                ]
       
        toolbar.isUserInteractionEnabled = true
        typeTextField.inputAccessoryView = toolbar
        dateTextField.inputAccessoryView = toolbar
        reminderTypeTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissPicker() {
        dateFormatter.dateFormat = "dd MMM EEEE, yyyy HH:mm"
        let date = dateFormatter.string(from: datePicker.date)
        dateTextField.text = "\(date)"
        delegate?.editingDone()
    }
    
}
