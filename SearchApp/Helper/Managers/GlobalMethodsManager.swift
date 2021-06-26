//
//  GlobalMethodsManager.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

class GlobalMethodsManager {
    static let shared = GlobalMethodsManager()
    
    //MARK: - Helper Methods
    func getBundle() -> Bundle {
        return Bundle(for: type(of: self))
    }
}
