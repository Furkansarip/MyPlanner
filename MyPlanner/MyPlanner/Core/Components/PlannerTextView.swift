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
        self.font = ThemeFont.regular(ofSize: 18)
        self.autocorrectionType = .no
        self.text = "Enter a description"
        self.backgroundColor = .tertiarySystemFill
        self.textColor = .secondaryLabel
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.layer.cornerRadius = 20
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemIndigo.cgColor
        /* self.layer.shadowColor = UIColor.gray.cgColor;
        self.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 20
        self.layer.masksToBounds = false */
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
