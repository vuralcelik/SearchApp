//
//  EmptyStateCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 30.06.2021.
//

import UIKit

class EmptyStateCell: BaseTableViewCell {
    //MARK: - Views
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var emptyInfoLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = L10n.searchEmptyInfoTitle
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(containerView)
        containerView.addSubview(emptyInfoLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        emptyInfoLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
