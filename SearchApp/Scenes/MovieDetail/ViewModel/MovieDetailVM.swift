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
    
    //MARK: - Navigated Properties
    var navigatedMovieBehaviorRelay = BehaviorRelay<MovieResponseModel?>(value: nil)
    
    //MARK: - Helper Methods
    func getSectionType(section: Int) -> MovieDetailVCSectionTypes {
        guard let validatedSectionType = MovieDetailVCSectionTypes(rawValue: section) else { return .coverPhoto }
        return validatedSectionType
    }
}

//MARK: - UITableView Delegate Methods
extension MovieDetailVM: UITableViewDelegate {
    
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
            return 1
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
            return UITableViewCell()
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
}

