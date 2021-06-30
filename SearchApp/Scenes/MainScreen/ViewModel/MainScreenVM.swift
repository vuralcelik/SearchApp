//
//  MainScreenVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import RxSwift
import RxCocoa
import UIKit

class MainScreenVM: BaseVM {
    //MARK: - Regular Properties
    var sections = MainScreenVCSectionTypes.allCases
    var searchType: MainScreenVCSearchTypes = .onlyPopularMovies
    weak var movieCollectionViewCellDelegate: MoviesCollectionViewCellDelegate?
    weak var peopleTableViewCellDelegate: PeopleTableViewCellDelegate?
    let scrollViewDidScrollPublishSubject = PublishSubject<UIScrollView>()
    var popularMoviesCurrentPage : Int = 0
    var searchMoviesCurrentPage : Int = 0
    var searchPeoplesCurrentPage : Int = 0
    var isLoadingList : Bool = false
    var searchText: String?
    
    //MARK: - Responses
    var getPopularMoviesResponse = BehaviorRelay<[MovieResponseModel]>(value: [])
    var getSearchMoviesResponse = BehaviorRelay<[MovieResponseModel]>(value: [])
    var getSearchPeoplesResponse = BehaviorRelay<[PeopleResponseModel]>(value: [])
    
    //MARK: - Requests
    func getPopularMovies() -> Observable<BasePaginationResponseModel<MovieResponseModel>>{
        popularMoviesCurrentPage += 1
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: APIConstants.apiKey,
                                                             language: "en-US",
                                                             page: popularMoviesCurrentPage.description)
        return Networking.request(router: MovieRouter.popular(queryStringRequest: queryStringRequest))
    }
    
    func getSearchMovies(searchText: String) -> Observable<BasePaginationResponseModel<MovieResponseModel>> {
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: APIConstants.apiKey,
                                                             language: "en-US",
                                                             page: searchMoviesCurrentPage.description,
                                                             query: searchText)
        return Networking.request(router: SearchRouter.movies(queryStringRequest: queryStringRequest))
    }
    
    func getSearchPeoples(searchText: String) -> Observable<BasePaginationResponseModel<PeopleResponseModel>> {
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: APIConstants.apiKey,
                                                             language: "en-US",
                                                             page: searchPeoplesCurrentPage.description,
                                                             query: searchText)
        return Networking.request(router: SearchRouter.people(queryStringRequest: queryStringRequest))
    }
    
    //MARK: - Helper Methods
    func getSectionType(section: Int) -> MainScreenVCSectionTypes {
        guard let validatedSectionType = MainScreenVCSectionTypes(rawValue: section) else { return .movies }
        return validatedSectionType
    }
    
    func shouldCallSearch(by textField: UITextField) -> Bool {
        return textField.text != nil && textField.text != "" && textField.text != " "
    }
    
    func shouldCallPopularMovies(by textField: UITextField) -> Bool {
        return !shouldCallSearch(by: textField)
    }
    
    func getMovie(by index: Int) -> MovieResponseModel {
        switch searchType {
        case .onlyPopularMovies:
            return getPopularMoviesResponse.value[index]
        case .multiSearch:
            return getSearchMoviesResponse.value[index]
        }
    }
    
    func getPeople(by index: Int) -> PeopleResponseModel {
        return getSearchPeoplesResponse.value[index]
    }
    
    func clearPageNumbersForNewSearch() {
        searchMoviesCurrentPage = 1
        searchPeoplesCurrentPage = 1
    }
    
    private func shouldShowEmptyState(section: Int) -> Bool {
        switch searchType {
        case .onlyPopularMovies:
            return getPopularMoviesResponse.value.count <= 0
        case .multiSearch:
            switch getSectionType(section: section) {
            case .movies:
                return getSearchMoviesResponse.value.count <= 0
            case .peoples:
                return getSearchPeoplesResponse.value.count <= 0
            }
        }
    }
}

//MARK: - UITableView Delegate Methods
extension MainScreenVM: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScrollPublishSubject.onNext(scrollView)
    }
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
        if shouldShowEmptyState(section: indexPath.section) {
            let cell = tableView.dequeueCell(withType: EmptyStateCell.self, for: indexPath) as! EmptyStateCell
            return cell
        }
        switch searchType {
        case .onlyPopularMovies:
            let cell = tableView.dequeueCell(withType: OnlyMovieCell.self, for: indexPath) as! OnlyMovieCell
            cell.movieModel = getPopularMoviesResponse.value[indexPath.row]
            return cell
        case .multiSearch:
            switch getSectionType(section: indexPath.section) {
            case .movies:
                let cell = tableView.dequeueCell(withType: MoviesTableViewCell.self, for: indexPath) as! MoviesTableViewCell
                cell.delegate = movieCollectionViewCellDelegate
                cell.moviesBehaviorRelay.accept(getSearchMoviesResponse.value)
                cell.collectionView.reloadData()
                return cell
            case .peoples:
                let cell = tableView.dequeueCell(withType: PeopleTableViewCell.self, for: indexPath) as! PeopleTableViewCell
                cell.delegate = peopleTableViewCellDelegate
                cell.peopleSearchBehaviorRelay.accept(getSearchPeoplesResponse.value)
                cell.collectionView.reloadData()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch searchType {
        case .onlyPopularMovies:
            return UITableView.automaticDimension
        case .multiSearch:
            switch getSectionType(section: indexPath.section) {
            case .movies:
                return 400
            case .peoples:
                return 200
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 55
        }
        return 40
    }
}
