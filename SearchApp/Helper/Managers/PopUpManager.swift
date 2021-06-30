//
//  PopUpManager.swift
//  SearchApp
//
//  Created by Vural Çelik on 30.06.2021.
//

import UIKit

class PopUpManager {
    static let loadingVC = LoadingVC()
    
    static func showLoading(fromVC: UIViewController,
                            completionHandler: ((UIViewController) -> Void)? = nil) {
        loadingVC.modalTransitionStyle = .crossDissolve
        loadingVC.modalPresentationStyle = .overFullScreen
        fromVC.present(loadingVC, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                completionHandler?(loadingVC)
            }
        }
    }
    
    static func showPopUp(fromVC: UIViewController,
                          title: String,
                          description: String? = nil,
                          buttonTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: description,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        alert.modalTransitionStyle = .crossDissolve
        alert.modalPresentationStyle = .overFullScreen
        fromVC.present(alert, animated: true)
    }
}
