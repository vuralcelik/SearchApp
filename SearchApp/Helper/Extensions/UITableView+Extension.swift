//
//  UITableView+Extension.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

extension UITableView {
    func registerCells(types: [UITableViewCell.Type], identifier: String? = nil) {
        types.forEach { type in
            let cellId = String(describing: type)
            register(type, forCellReuseIdentifier: identifier ?? cellId)
        }
    }
    
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }
    
    func reloadTableViewWithoutAnimation() {
        UIView.performWithoutAnimation {
            let loc = self.contentOffset
            self.reloadData()
            self.contentOffset = loc
        }
    }
}
