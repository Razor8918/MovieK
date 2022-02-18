//
//  ScrollableMoviesCollectionViewCell.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 08.02.2022.
//

import UIKit
import SnapKit

final class ScrollableMoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    private var viewModel: ViewModel?
    
    private let mainImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupConstraints()
        configureImageView()
        
        backgroundColor = .black
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
        updateUI()
    }
}

// MARK: - Private Methods

private extension ScrollableMoviesCollectionViewCell {
    func setupConstraints() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieDescriptionLabel)
        
        mainImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
        
        movieDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(1)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
        
    func configureImageView() {
        mainImageView.layer.cornerRadius = 10
    }
    
    func updateUI() {
        guard let viewModel = viewModel else { return }
        
        movieTitleLabel.textColor = .white
        movieDescriptionLabel.textColor = .white
        movieTitleLabel.textAlignment = .center
        movieDescriptionLabel.textAlignment = .center
        
        mainImageView.image = viewModel.image
        movieTitleLabel.text = viewModel.title
        movieDescriptionLabel.text = viewModel.description
    }
}

// MARK: - ViewModel
extension ScrollableMoviesCollectionViewCell {
    struct ViewModel {
        let image: UIImage
        let title: String
        let description: String
    }
}
