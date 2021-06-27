//
//  UICollectionView+Extension.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

extension UICollectionView {
    func registerCells(types: [UICollectionViewCell.Type], identifier: String? = nil) {
        types.forEach { type in
            let cellId = String(describing: type)
            register(type, forCellWithReuseIdentifier: identifier ?? cellId)
        }
    }
    
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(type, forCellWithReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}
