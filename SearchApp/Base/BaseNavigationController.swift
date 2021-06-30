//
//  BaseNavigationController.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class BaseNavigationController: UINavigationController {
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
    }
}
