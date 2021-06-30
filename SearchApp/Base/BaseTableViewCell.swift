//
//  BaseTableViewCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func commonInit() {
        setupViews()
        setupLayout()
    }
    
    //MARK: - UI Configuration
    func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func setupLayout() {
        
    }
}
