//
//  CustomButton.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class CustomButton: UIButton {
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
        
    }
    
    //MARK: - UI Configuration
    func setupButton(title: String? = nil,
                     font: UIFont? = FontFamily.SourceSansPro.bold.font(size: 16),
                     titleColor: UIColor? = ColorName.customBlack.color,
                     backgroundColor: UIColor = ColorName.customGray.color,
                     cornerRadius: CGFloat = 4) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = cornerRadius
    }
}
