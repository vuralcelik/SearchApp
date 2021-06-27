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
        let itemWidth = UIScreen.main.bounds.size.width - 32
        layout.itemSize = CGSize(width: itemWidth, height: 232)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.bounces = true
        view.backgroundColor = .clear
        view.registerCells(types: [MovieCell.self])
        view.dataSource = self
        return view
    }()
    
    //MARK: - Computed Properties
    var moviesBehaviorRelay = BehaviorRelay<[MovieResponseModel]>(value: [])
    
    //MARK: - Properties
    var disposeBag = DisposeBag()
    weak var delegate: MoviesCollectionViewCellDelegate?
    
    //MARK: - Events
    private func initializeEvents() {
        collectionView
        .rx
        .itemSelected
        .subscribe(onNext:{ [weak self] indexPath in
            self?.delegate?.itemSelectedAtMoviesCollectionView(index: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Life Cycle
    override func commonInit() {
        super.commonInit()
        initializeEvents()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        collectionView.snp.updateConstraints { (make) in
//            make.height.equalTo(collectionView.collectionViewLayout.collectionViewContentSize.height)
//        }
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
//            make.height.equalTo(0)
        }
    }
}

//MARK: - UICollectionView DataSource Methods
extension MoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesBehaviorRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: MovieCell.self, for: indexPath) as! MovieCell
        cell.movieModel = moviesBehaviorRelay.value[indexPath.row]
        return cell
    }
}
