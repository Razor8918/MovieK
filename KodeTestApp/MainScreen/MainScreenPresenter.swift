//
//  MainScreenPresenter.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 06.02.2022.
//

import Foundation
import UIKit

protocol MainScreenPresenter {
    func getPopularMovies() -> [Movie]
    func getTvShowsMovies() -> [Movie]
    func getContinueMovies() -> [Movie]
    func didTriggerViewReadyEvent()
}

final class MainScreenPresenterImp {
    // MARK: - Private Properties
    
    private let homeGateway: HomeGateway
    
    private var popularMovies: [Movie] = []
    private var tvShowsMovies: [Movie] = []
    private var continueMovies: [Movie] = []
    
    //MARK: - Internal Properties
    
    weak var view: MainScreenView?
    
    //MARK: - Initialization
    
    init(homeGateway: HomeGateway) {
        self.homeGateway = homeGateway
    }
}

//MARK: - MainScreenPresenter
extension MainScreenPresenterImp: MainScreenPresenter {
    func getPopularMovies() -> [Movie] {
        return popularMovies
    }
    
    func getTvShowsMovies() -> [Movie] {
        return tvShowsMovies
    }
    
    func getContinueMovies() -> [Movie] {
        return continueMovies
    }
    
    func didTriggerViewReadyEvent() {
        fetchMovies()
    }
}

// MARK: - Private Methods
private extension MainScreenPresenterImp {
    func fetchMovies() {
        let firstMovie = Movie(
            imageData: UIImage(named: "bannerImage1")?.pngData(),
            title: "Чудо Женщина",
            description: "2022"
        )
        
        let secondMovie = Movie(
            imageData: UIImage(named: "bannerImage2")?.pngData(),
            title: "Бэтмен",
            description: "2022"
        )
        
        popularMovies = [
            firstMovie,
            secondMovie
        ]
        
        tvShowsMovies = [
            firstMovie,
            secondMovie
        ]
        
        continueMovies = [
            firstMovie,
            secondMovie
        ]
        
        homeGateway.getFavouriteMovies { [weak self] result in
            switch result {
            case.success(let movies):
                guard let movies = movies else { return }
                self!.popularMovies = movies
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
