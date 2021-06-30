//
//  PeopleDetailVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleDetailVM: BaseVM {
    //MARK: - Regular Properties
    
    //MARK: - Responses
    var peopleDetailResponse = BehaviorRelay<PeopleDetailResponseModel>(value: PeopleDetailResponseModel())
    var peopleDetailMovieCreditsResponse = BehaviorRelay<MovieCreditsResponseModel?>(value: nil)
    
    //MARK: - NavigatedProperties
    var navigatedPeopleResponse = BehaviorRelay<PeopleResponseModel?>(value: nil)
    
    //MARK: - Requests
    func getPeopleDetail() -> Observable<PeopleDetailResponseModel>{
        let pathVariableRequest = PeopleDetailPathVariableRequestModel(personId: navigatedPeopleResponse.value?.id ?? 0)
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "en-US")
        return Networking.request(router: PeopleRouter.detail(pathVariableRequest: pathVariableRequest,
                                                              queryStringRequest: queryStringRequest))
    }
    
    func getPeopleMovieCredits() -> Observable<MovieCreditsResponseModel> {
        let pathVariableRequest = PeopleDetailPathVariableRequestModel(personId: navigatedPeopleResponse.value?.id ?? 0)
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "en-US")
        return Networking.request(router: PeopleRouter.movieCredits(pathVariableRequest: pathVariableRequest,
                                                                    queryStringRequest: queryStringRequest))
    }
}

//MARK: - UICollectionView DataSource Methods
extension PeopleDetailVM: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let validatedCount = peopleDetailMovieCreditsResponse.value?.cast?.count else { return 0 }
        return validatedCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: MovieCell.self, for: indexPath) as! MovieCell
        cell.castModel = peopleDetailMovieCreditsResponse.value?.cast?[indexPath.row]
        return cell
    }
}
