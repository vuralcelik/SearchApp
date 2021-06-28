//
//  MoviesCollectionView.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol MoviesCollectionViewCellDelegate: class {
    func itemSelectedAtMoviesCollectionView(index: Int)
}

class MoviesTableViewCell: BaseTableViewCell {
    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 210,
                                 height: 400)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.bounces = true
        view.backgroundColor = .clear
        view.registerCells(types: [MovieCell.self])
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Computed Properties
    var moviesSearchBehaviorRelay = BehaviorRelay<[MovieResponseModel]>(value: [])
    
    //MARK: - Properties
    var disposeBag = DisposeBag()
    weak var delegate: MoviesCollectionViewCellDelegate?
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UICollectionView DataSource Methods
extension MoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesSearchBehaviorRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: MovieCell.self, for: indexPath) as! MovieCell
        cell.movieSearchModel = moviesSearchBehaviorRelay.value[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionView Delegate Methods
extension MoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelectedAtMoviesCollectionView(index: indexPath.row)
    }
}
