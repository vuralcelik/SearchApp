//
//  MovieDetailVM.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailVM: BaseVM {
    //MARK: - Regular Properties
    var sections = MovieDetailVCSectionTypes.allCases
    
    //MARK: - Responses
    var movieCreditsResponse = BehaviorRelay<MovieCreditsResponseModel>(value: MovieCreditsResponseModel())
    
    //MARK: - Navigated Properties
    var navigatedMovieBehaviorRelay = BehaviorRelay<MovieResponseModel?>(value: nil)
    
    //MARK: - Requests
    func getMovieCredits() -> Observable<MovieCreditsResponseModel> {
        let pathVariableRequest = MovieCreditsPathVariableRequestModel(id: navigatedMovieBehaviorRelay.value?.id ?? 0)
        let queryStringRequest = BaseQueryStringRequestModel(apiKey: APIConstants.apiKey,
                                                             language: "en-US")
        return Networking.request(router: MovieRouter.credits(pathVariableRequest: pathVariableRequest,
                                                              queryStringRequest: queryStringRequest))
    }
    
    //MARK: - Helper Methods
    func getSectionType(section: Int) -> MovieDetailVCSectionTypes {
        guard let validatedSectionType = MovieDetailVCSectionTypes(rawValue: section) else { return .coverPhoto }
        return validatedSectionType
    }
}

//MARK: - UITableView DataSource Methods
extension MovieDetailVM: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch getSectionType(section: section) {
        case .coverPhoto:
            return 1
        case .information:
            return 1
        case .castMembers:
            guard let validatedCount = movieCreditsResponse.value.cast?.count else { return 0 }
            return validatedCount
        case .videos:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch getSectionType(section: indexPath.section) {
        case .coverPhoto:
            let cell = tableView.dequeueCell(withType: CoverPhotoCell.self, for: indexPath) as! CoverPhotoCell
            cell.movieModel = navigatedMovieBehaviorRelay.value
            return cell
        case .information:
            let cell = tableView.dequeueCell(withType: MovieDetailInformationsCell.self, for: indexPath) as! MovieDetailInformationsCell
            cell.movieModel = navigatedMovieBehaviorRelay.value
            return cell
        case .castMembers:
            let cell = tableView.dequeueCell(withType: MoviesTableViewCell.self, for: indexPath) as! MoviesTableViewCell
            guard let validatedCastModel = movieCreditsResponse.value.cast else {
                return cell
            }
            cell.moviesBehaviorRelay.accept(validatedCastModel)
            cell.collectionView.reloadData()
            return cell
        case .videos:
            let cell = tableView.dequeueCell(withType: MovieDetailLinkCell.self, for: indexPath) as! MovieDetailLinkCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch getSectionType(section: section) {
        case .coverPhoto:
            return nil
        case .information:
            return L10n.movieDetailInformationsHeaderTitle
        case .castMembers:
            return L10n.movieDetailCastMembersHeaderTitle
        case .videos:
            return L10n.movieDetailVideosHeaderTitle
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch getSectionType(section: indexPath.section) {
        case .coverPhoto:
            return 305
        case .castMembers:
            return 400
        default:
            return UITableView.automaticDimension
        }
    }
}

