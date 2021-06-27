//
//  BaseVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation
import RxSwift

protocol StateChange {
    
}

class BaseVM<T: StateChange>: NSObject {
    let disposeBag = DisposeBag()
    let emitter = PublishSubject<StateChange>()
}
