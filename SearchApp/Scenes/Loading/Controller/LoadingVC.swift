//
//  LoadingVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 30.06.2021.
//

import UIKit

class LoadingVC: BaseVC {
    //MARK: - Views
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.tintColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorName.customBlack.color.withAlphaComponent(0.25)
        activityIndicatorView.startAnimating()
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        view.addSubview(activityIndicatorView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        activityIndicatorView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        
    }
}
