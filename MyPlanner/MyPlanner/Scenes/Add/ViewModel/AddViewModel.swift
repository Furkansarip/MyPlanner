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
    let typeArray: [String] = BaseEnum.allCases.map { $0.rawValue }
    let reminderArray = ["15 Min","30 Min","1 Hour"]
    let titleTextField = PlannerTextField()
    let dateTextField = PlannerTextField()
    let typeTextField = PlannerTextField()
    let descriptionTextField = PlannerTextView()
    let reminderTypeTextField = PlannerTextField()
    let addButton = PlannerButton()
    let dateFormatter = DateFormatter()
    let typePicker = UIPickerView()
    let reminderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let imageView = UIImageView()
    var isReminderPage = false
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
        view.addSubview(imageView)
        view.addSubview(stackView)
        view.addSubview(addButton)
        imageView.image = UIImage(named: "reminder2")
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.customizeButton(color: .systemIndigo, textColor: .label)
        titleTextField.setupTextField(placeholder: "Title")
        typeTextField.setupTextField(placeholder: "Choose a Type")
        dateTextField.setupTextField(placeholder: "Date")
        reminderTypeTextField.setupTextField(placeholder: "Timer")
        pickerDoneAction()
        let padding: CGFloat = 8
        let stackViewWidth = view.frame.width - padding
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            typeTextField.heightAnchor.constraint(equalToConstant: 50),
            dateTextField.heightAnchor.constraint(equalToConstant: 50),
            reminderTypeTextField.heightAnchor.constraint(equalToConstant: 50),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 140),
            addButton.widthAnchor.constraint(equalToConstant: stackViewWidth - 60),
            
            imageView.heightAnchor.constraint(equalToConstant: 200),
            /*stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -padding),
            
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30)*/
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            addButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
           
            
        ])
    }
    
    func setReminder(title: String, body:String, targetDate: Date) {
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
            print("hello")
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
