//
//  BaseCollectionViewCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setupViews()
        setupLayout()
    }
    
    //MARK: - UI Configuration
    func setupViews() {
        
    }
    
    func setupLayout() {
        
    }
}
