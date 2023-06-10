//
//  AddViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 3.06.2023.
//

import UIKit

class AddViewController: UIViewController {

    let titleTextField = PlannerTextField()
    let dateTextField = PlannerTextField()
    let typeTextField = PlannerTextField(frame: CGRect(x: 0, y: 0, width: 35, height: 65))
    let descriptionTextField = PlannerTextView()
    let reminderTypeTextField = PlannerTextField()
    let addButton = UIButton(type: .system)
    let typePicker = UIPickerView()
    let reminderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let typeArray = ["Choose 🕹","Money 💰","Health 🩺","Life 🏡"]
    let reminderArray = ["15 Min","30 Min","1 Hour"]
    var data = [PlannerModel]()
    let isReminderPage = true
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePicker()
        layout()
        createToolbar()
        title = "Add Page"
        
        if isReminderPage == false {
            reminderTypeTextField.removeFromSuperview()
        }
    }
   
    private func configurePicker() {
        typeTextField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
        
        dateTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "tr_TR") as Locale
        datePicker.timeZone = TimeZone.current
        
        reminderTypeTextField.inputView = reminderPicker
        reminderPicker.delegate = self
        reminderPicker.dataSource = self
        
    }
    
    private func layout() {
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
    
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM EEEE, HH:mm"
        let date = dateFormatter.string(from: datePicker.date)
        dateTextField.text = "\(date)"
        view.endEditing(true)
    }
    
    @objc func addButtonAction() {
        
        ReminderDataManager.shared.saveReminder(title: titleTextField.text!, date: dateTextField.text!, reminderType: reminderTypeTextField.text!, type: typeTextField.text!, description: descriptionTextField.text!)
        ReminderDataManager.shared.getReminders()
    }

}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == typePicker {
            return typeArray.count
        } else {
            return reminderArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == typePicker {
            return typeArray[row]
        } else {
            return reminderArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == typePicker {
            typeTextField.text = typeArray[row]
        } else {
            reminderTypeTextField.text = reminderArray[row]
        }
    }
    
}
