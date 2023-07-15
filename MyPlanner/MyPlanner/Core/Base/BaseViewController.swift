//
//  BaseViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 3.06.2023.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {
    weak var baseDelegate: BaseDelegate?
    let indicator = MaterialActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPage))
        setupActivityIndicatorView()
    }
    
    private func setupActivityIndicatorView() {
        indicator.color = .purple
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showAlert(title: String?, message: String?, backgroundColor: UIColor = .systemBackground) {
        SwiftAlertView.show(title: title, message: message, buttonTitles: ["OK"]) { alertView in
            alertView.backgroundColor = backgroundColor
            alertView.titleLabel.textColor = .label
            alertView.messageLabel.textColor = .label
            alertView.tintColor = .red
        }
    }
    
    @objc func addPage() {
       /* view.backgroundColor = .clear
        // 2
        let blurEffect = UIBlurEffect(style: .regular)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
          blurView.topAnchor.constraint(equalTo: view.topAnchor),
          blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]) */
        targetViewController()
    }
}

extension BaseViewController: BaseProtocol {
    func targetViewController() {
        let chooseView = ChooseView(frame: .zero)
        baseDelegate?.getView(targetView: chooseView)
    }
    
}

