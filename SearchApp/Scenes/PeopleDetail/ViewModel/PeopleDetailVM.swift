//
//  PeopleDetailVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import Foundation
import RxSwift
import RxCocoa

class PeopleDetailVM: BaseVM {
    //MARK: - Regular Properties
    
    var navigatedPeopleResponse = BehaviorRelay<PeopleResponseModel?>(value: nil)
}
