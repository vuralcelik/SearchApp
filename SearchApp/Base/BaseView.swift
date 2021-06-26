//
//  BaseView.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class BaseView: UIView {
    //MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
