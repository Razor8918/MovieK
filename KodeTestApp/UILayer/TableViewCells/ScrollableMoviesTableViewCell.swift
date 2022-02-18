//
//  ScrollableMoviesTableViewCell.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 08.02.2022.
//

import UIKit
import SnapKit

final class ScrollableMoviesTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var viewModel: ViewModel?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupCollectionView()
        
        backgroundColor = .black
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadSections([0])
    }
}

// MARK: - Private Methods

private extension ScrollableMoviesTableViewCell {
    func setupConstraints() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(235)
        }
    }
    
    func setupCollectionView() {
        registerCells()
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 240)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func registerCells() {
        collectionView.register(ScrollableMoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ScrollableMoviesCollectionViewCell")
    }
    
    func getMovieCell(indexPath: IndexPath) -> ScrollableMoviesCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrollableMoviesCollectionViewCell", for: indexPath) as? ScrollableMoviesCollectionViewCell,
              let item = viewModel?.items[indexPath.row]
        else { return ScrollableMoviesCollectionViewCell() }
        
        let cellViewModel = ScrollableMoviesCollectionViewCell.ViewModel(
            image: item.image,
            title: item.title,
            description: item.description
        )
        
        cell.configure(viewModel: cellViewModel)
        
        return cell
    }
}

// MARK: - UITableViewDataSource

extension ScrollableMoviesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getMovieCell(indexPath: indexPath)
    }
}

// MARK: - ViewModel

extension ScrollableMoviesTableViewCell {
    struct ViewModel {
        let items: [Item]
        
        struct Item {
            let image: UIImage
            let title: String
            let description: String
        }
    }
}
