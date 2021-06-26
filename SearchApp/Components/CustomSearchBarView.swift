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
    
    func setupSearchBar(textFieldPlaceholderText: String? = nil,
                        textFieldFont: UIFont = FontFamily.SourceSansPro.regular.font(size: 14),
                        textFieldTextColor: UIColor = ColorName.customBlack.color,
                        textFieldKeyboardType: UIKeyboardType = .default,
                        textFieldAutocorrectionType: UITextAutocorrectionType = .no,
                        textFieldTextContentType: UITextContentType? = nil,
                        textFieldAlignment: NSTextAlignment = .left,
                        buttonTitle: String? = nil,
                        buttonFont: UIFont? = FontFamily.SourceSansPro.bold.font(size: 16),
                        buttonTitleColor: UIColor? = ColorName.customBlack.color,
                        buttonBackgroundColor: UIColor = ColorName.customGray.color,
                        buttonCornerRadius: CGFloat = 4) {
        customTextFieldView.setupTextFieldView(placeholderText: textFieldPlaceholderText,
                                               font: textFieldFont,
                                               textColor: textFieldTextColor,
                                               keyboardType: textFieldKeyboardType,
                                               autocorrectionType: textFieldAutocorrectionType,
                                               textContentType: textFieldTextContentType,
                                               textFieldAlignment: textFieldAlignment)
        customButton.setupButton(title: buttonTitle,
                                 font: buttonFont,
                                 titleColor: buttonTitleColor,
                                 backgroundColor: buttonBackgroundColor,
                                 cornerRadius: buttonCornerRadius)
    }
}
