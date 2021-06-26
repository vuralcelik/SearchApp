//
//  CustomTextFieldView.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class CustomTextFieldView: BaseView {
    //MARK: - Views
    lazy var textField: UITextField = {
        let view = UITextField()
        view.backgroundColor = ColorName.customGray.color
        return view
    }()
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        
        addSubview(textField)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        textField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTextFieldView(placeholderText: String? = nil,
                            font: UIFont = FontFamily.SourceSansPro.regular.font(size: 14),
                            textColor: UIColor = ColorName.customBlack.color,
                            keyboardType: UIKeyboardType = .default,
                            autocorrectionType: UITextAutocorrectionType = .no,
                            textContentType: UITextContentType? = nil,
                            textFieldAlignment: NSTextAlignment = .left) {
        textField.placeholder = placeholderText
        textField.textColor = textColor
        textField.font = font
        textField.keyboardType = keyboardType
        textField.autocorrectionType = autocorrectionType
        textField.textContentType = textContentType
        textField.textAlignment = textFieldAlignment
    }
}
