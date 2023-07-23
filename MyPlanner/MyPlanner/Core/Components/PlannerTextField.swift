//
//  PlannerTextField.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 5.06.2023.
//

import UIKit

final class PlannerTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField(placeholder: String) {
        textColor = .label
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.4
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemIndigo.cgColor
        layer.shadowOffset = CGSize(width: 15, height: 15)
        tintColor = .secondaryLabel
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        font = ThemeFont.regular(ofSize: 18)
        autocorrectionType = .no
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
