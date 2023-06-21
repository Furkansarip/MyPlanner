//
//  BaseProtocol.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 21.06.2023.
//

import UIKit

protocol BaseProtocol {
    func targetViewController()
    var baseDelegate: BaseDelegate? { get set }
}

protocol BaseDelegate: AnyObject {
    func getView(targetView: ChooseView)
}
