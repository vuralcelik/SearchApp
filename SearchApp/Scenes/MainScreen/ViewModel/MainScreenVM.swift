//
//  MainScreenVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import RxSwift

class MainScreenVM: BaseVM {
    var items = Observable<[String]>.of(
        ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    )
}
