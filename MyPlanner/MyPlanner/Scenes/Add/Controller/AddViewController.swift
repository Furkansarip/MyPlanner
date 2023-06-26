//
//  AddViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 3.06.2023.
//

import UIKit

class AddViewController: UIViewController {
    let viewModel = AddViewModel()
    var isReminderPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.configurePicker(delegate: self)
        viewModel.loadUI(view: view)
        title = "Add Page"
        
        if !isReminderPage {
            viewModel.reminderTypeTextField.removeFromSuperview()
        }
    }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == viewModel.typePicker {
            return viewModel.typeCount()
        } else {
            return viewModel.reminderCount()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == viewModel.typePicker {
            viewModel.typeTextField.text = viewModel.typeArray[0]
            return viewModel.typeArray[row]
        } else {
            return viewModel.reminderArray[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == viewModel.typePicker {
            viewModel.typeTextField.text = viewModel.typeArray[row]
        } else {
            viewModel.reminderTypeTextField.text = viewModel.reminderArray[row]
        }
    }
    
}

extension AddViewController: AddViewModelDelegate {
    func popController() {
        navigationController?.popViewController(animated: true)
    }
    
    func editingDone() {
        view.endEditing(true)
    }
}
