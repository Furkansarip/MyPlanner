//
//  PlannerTextView.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 6.06.2023.
//

import UIKit

final class PlannerTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureTextView()
    }
    
    private func configureTextView() {
        font = ThemeFont.regular(ofSize: 18)
        autocorrectionType = .no
        text = "Enter a description"
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        layer.cornerRadius = 20
        textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemIndigo.cgColor
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
