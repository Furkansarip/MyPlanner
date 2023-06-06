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
    let dummyField = PlannerTextView()
    let addButton = UIButton(type: .system)
    let typePicker = UIPickerView()
    let typeArray = ["Choose 🕹","Money 💰","Health 🩺","Life 🏡"]
    var data = [PlannerModel]()
    private lazy var stackView: UIStackView = {
      let stackView = UIStackView(arrangedSubviews: [
      titleTextField,
      dateTextField,
      typeTextField,
      dummyField
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
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
   
    private func configurePicker() {
        typeTextField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    
    private func layout() {
        view.addSubview(stackView)
        view.addSubview(addButton)
        titleTextField.placeholder = "Title"
        typeTextField.placeholder = "Type"
        dateTextField.placeholder = "Date"
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 35),
            typeTextField.heightAnchor.constraint(equalToConstant: 35),
            dateTextField.heightAnchor.constraint(equalToConstant: 35),
            //stackView.heightAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: addButton.topAnchor,constant: -30),
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
        
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @objc func addButtonAction() {
        //guard let title = titleTextField.text else { return }
        let object = PlannerModel(title: titleTextField.text!, description: dateTextField.text!, type: typeTextField.text!)
        data.append(object)
        print(data)
    }

}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeTextField.text = typeArray[row]
    }
    
}
