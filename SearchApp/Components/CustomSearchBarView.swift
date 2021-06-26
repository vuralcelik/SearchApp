//
//  CustomSearchBarView.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class CustomSearchBarView: BaseView {
    //MARK: - Views
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [customTextFieldView,
                                                  customButton])
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 4
        return view
    }()
    
    lazy var customTextFieldView: CustomTextFieldView = {
        let view = CustomTextFieldView()
        view.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        return view
    }()
    
    lazy var customButton: CustomButton = {
        let view = CustomButton()
        return view
    }()
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        
        addSubview(containerStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
