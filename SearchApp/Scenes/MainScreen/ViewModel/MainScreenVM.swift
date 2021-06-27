//
//  MainScreenVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import RxSwift
import RxCocoa
import UIKit

enum MainScreenVMStateChange: StateChange {
    
}

class MainScreenVM: BaseVM<MainScreenVMStateChange> {
    //MARK: - Regular Properties
    var sections = MainScreenVCSectionTypes.allCases
    
    //MARK: - Responses
    var getPopularPeoplesResponse = BehaviorRelay<[MovieResponseModel]>(value: [])
    
    //MARK: - Requests
    func getPopularMovies() -> Observable<BasePaginationResponseModel<MovieResponseModel>>{
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "tr_TR",
                                                             page: "1",
                                                             region: "tr")
        return Networking.request(router: MovieRouter.popular(queryStringRequest: queryStringRequest))
    }
    
//    func getPopularPeoples() -> Observable<BasePaginationResponseModel<PeopleResponseModel>> {
//        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
//                                                             language: "tr_TR",
//                                                             page: "1")
//        return Networking.request(router: PeopleRouter.popular(queryStringRequest: queryStringRequest))
//    }
    
    //MARK: - Helper Methods
    private func getSectionType(section: Int) -> MainScreenVCSectionTypes {
        guard let validatedSectionType = MainScreenVCSectionTypes(rawValue: section) else { return .movies }
        return validatedSectionType
    }
}

//MARK: - UITableView Delegate Methods
extension MainScreenVM: UITableViewDelegate {
    
}

//MARK: - UITableView DataSource Methods
extension MainScreenVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch getSectionType(section: indexPath.section) {
        case .movies:
            let cell = tableView.dequeueCell(withType: MoviesTableViewCell.self, for: indexPath) as! MoviesTableViewCell
            cell.moviesBehaviorRelay.accept(getPopularPeoplesResponse.value)
            cell.collectionView.reloadData()
            return cell
        case .peoples:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch getSectionType(section: section) {
        case .movies:
            return L10n.searchMovieHeaderTitle
        case .peoples:
            return L10n.searchPeopleHeaderTitle
        }
    }
}
