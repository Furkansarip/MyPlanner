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
        layer.cornerRadius = 6
        layer.borderWidth = 1
        backgroundColor = color
        titleColor(for: .focused)
        tintColor = textColor
    }
}

extension PlannerButton {
    func alignImageAndTitleVertically(padding: CGFloat = 4.0) {
            let imageSize = imageView!.frame.size
            let titleSize = titleLabel!.frame.size
            let totalHeight = imageSize.height + titleSize.height + padding

            imageEdgeInsets = UIEdgeInsets(
                top: -(totalHeight - imageSize.height),
                left: 0,
                bottom: 0,
                right: -titleSize.width
            )

            titleEdgeInsets = UIEdgeInsets(
                top: 0,
                left: -imageSize.width,
                bottom: -(totalHeight - titleSize.height),
                right: 0
            )
        }
}
