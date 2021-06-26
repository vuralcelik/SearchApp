//
//  BaseVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
    //MARK: - Computed Properties
    var isNavigationBarHidden: Bool = false {
        didSet {
            navigationController?.isNavigationBarHidden = isNavigationBarHidden
        }
    }
    
    var vcBackgroundcolor: UIColor = .white {
        didSet {
            view.backgroundColor = vcBackgroundcolor
        }
    }
    
    var navBarBackgroundColor: UIColor = .white {
        didSet {
            navigationController?.navigationBar.barTintColor = navBarBackgroundColor
        }
    }
    
    //MARK: - Properties
    let disposeBag = DisposeBag()

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    deinit {
        #if DEBUG
            print(String(describing: self) + "deinitialized.")
        #endif
    }
    
    //MARK: - UI Configuration
    func setupViews() {
        vcBackgroundcolor = .white
    }
    
    func setupLayout() {}
    
    func setupNavBar() {}
    
    //MARK: - Helper Methods
    func observeViewModel() {}
    
    //MARK: - Navigations
    func push(to: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(to, animated: animated)
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}
