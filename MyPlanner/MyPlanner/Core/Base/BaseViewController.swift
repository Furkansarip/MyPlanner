//
//  BaseViewController.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 3.06.2023.
//

import UIKit
import MaterialActivityIndicator

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
    
    @objc func addPage() {
        targetViewController()
    }
}

extension BaseViewController: BaseProtocol {
    func targetViewController() {
        let chooseView = ChooseView(frame: .zero)
        baseDelegate?.getView(targetView: chooseView)
    }
    
}

