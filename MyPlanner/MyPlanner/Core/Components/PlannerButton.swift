//
//  PlannerButton.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 18.06.2023.
//

import Foundation
import UIKit

final class PlannerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeButton(color: UIColor, textColor: UIColor) {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        backgroundColor = color
        titleColor(for: .focused)
        tintColor = textColor
    }
}
