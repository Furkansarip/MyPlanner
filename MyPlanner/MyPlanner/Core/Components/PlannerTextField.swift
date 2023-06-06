//
//  PlannerTextField.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 5.06.2023.
//

import UIKit

final class PlannerTextField: UITextField {
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.leftView = paddingView
        self.leftViewMode = .always
        self.accessibilityPath?.lineWidth = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
