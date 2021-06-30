//
//  PeopleTableViewCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit
import RxCocoa

protocol PeopleTableViewCellDelegate: class {
    func scrollViewDidScrollInSearchPeoplesCollection(_ scrollView: UIScrollView)
    func itemSelectedInPeopleCollectionView(index: Int)
}

class PeopleTableViewCell: BaseTableViewCell {
    //MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 105,
                                 height: 200)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.bounces = true
        view.backgroundColor = .clear
        view.registerCells(types: [PeopleCell.self])
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    //MARK: - Computed Properties
    var peopleSearchBehaviorRelay = BehaviorRelay<[PeopleResponseModel]>(value: [])
    
    //MARK: - Properties
    weak var delegate: PeopleTableViewCellDelegate?
    
    //MARK: - Life Cycle
    override func commonInit() {
        super.commonInit()
        
    }
    
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
extension PeopleTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleSearchBehaviorRelay.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(withType: PeopleCell.self, for: indexPath) as! PeopleCell
        cell.peopleSearchModel = peopleSearchBehaviorRelay.value[indexPath.row]
        return cell
    }
}

//MARK: - UICollectionView Delegate Methods
extension PeopleTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelectedInPeopleCollectionView(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScrollInSearchPeoplesCollection(scrollView)
    }
}
