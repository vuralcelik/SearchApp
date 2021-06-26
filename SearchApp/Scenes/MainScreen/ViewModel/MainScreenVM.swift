//
//  MainScreenVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import RxSwift
import RxCocoa

class MainScreenVM: BaseVM {
    //MARK: - Properties
    var getPopularMoviesResponse = BehaviorRelay<[MovieResponseModel]>(value: [])
    var getPopularPeoplesResponse = BehaviorRelay<[PeopleResponseModel]>(value: [])
    
    //MARK: - Requests
    func getPopularMovies() -> Observable<BasePaginationResponseModel<MovieResponseModel>>{
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "tr_TR",
                                                             page: "1",
                                                             region: "tr")
        return Networking.request(router: MovieRouter.popular(queryStringRequest: queryStringRequest))
    }
    
    func getPopularPeoples() -> Observable<BasePaginationResponseModel<PeopleResponseModel>> {
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "tr_TR",
                                                             page: "1")
        return Networking.request(router: PeopleRouter.popular(queryStringRequest: queryStringRequest))
    }
}
