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
    var searchType: MainScreenVCSearchTypes = .onlyPopularMovies
    
    //MARK: - Responses
    var getPopularMoviesResponse = BehaviorRelay<[MovieResponseModel]>(value: [])
    var getPopularPeoplesResponse = BehaviorRelay<[PeopleResponseModel]>(value: [])
    var getMultiSearchResponse = BehaviorRelay<[MultiSearchResponseModel]>(value: [])
    
    //MARK: - Requests
    func getPopularMovies() -> Observable<BasePaginationResponseModel<MovieResponseModel>>{
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "en-US",
                                                             page: "1")
        return Networking.request(router: MovieRouter.popular(queryStringRequest: queryStringRequest))
    }
    
    func getPopularPeoples() -> Observable<BasePaginationResponseModel<PeopleResponseModel>> {
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "en-US",
                                                             page: "1")
        return Networking.request(router: PeopleRouter.popular(queryStringRequest: queryStringRequest))
    }
    
    func getMultiSearch(searchText: String?) -> Observable<BasePaginationResponseModel<MultiSearchResponseModel>>? {
        guard let validatedSearchText = searchText else { return nil }
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: "d5155429a4ca75afc8742180a5108788",
                                                             language: "en-US",
                                                             page: "1",
                                                             query: validatedSearchText)
        return Networking.request(router: SearchRouter.mutliSearch(queryStringRequest: queryStringRequest))
    }
    
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
        switch searchType {
        case .onlyPopularMovies:
            return 1
        case .multiSearch:
            return sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchType {
        case .onlyPopularMovies:
            return getPopularMoviesResponse.value.count
        case .multiSearch:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchType {
        case .onlyPopularMovies:
            let cell = tableView.dequeueCell(withType: OnlyMovieCell.self, for: indexPath) as! OnlyMovieCell
            cell.movieModel = getPopularMoviesResponse.value[indexPath.row]
            return cell
        case .multiSearch:
            switch getSectionType(section: indexPath.section) {
            case .movies:
                let cell = tableView.dequeueCell(withType: MoviesTableViewCell.self, for: indexPath) as! MoviesTableViewCell
                cell.moviesBehaviorRelay.accept(getPopularMoviesResponse.value)
                cell.collectionView.reloadData()
                return cell
            case .peoples:
                let cell = tableView.dequeueCell(withType: PeopleTableViewCell.self, for: indexPath) as! PeopleTableViewCell
                cell.collectionView.reloadData()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch searchType {
        case .onlyPopularMovies:
            return 500
        case .multiSearch:
            switch getSectionType(section: indexPath.section) {
            case .movies:
                return 350
            case .peoples:
                return 132
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch searchType {
        case .onlyPopularMovies:
            return nil
        case .multiSearch:
            switch getSectionType(section: section) {
            case .movies:
                return L10n.searchMovieHeaderTitle
            case .peoples:
                return L10n.searchPeopleHeaderTitle
            }
        }
    }
}
