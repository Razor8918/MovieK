//
//  MainScreenViewController.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 06.02.2022.
//

import UIKit
import SnapKit

protocol MainScreenView: AnyObject {
    
}


final class MainScreenViewController: UIViewController {
    
    var presenter: MainScreenPresenter?
    
    let tableView = UITableView()
    let myNameLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Razor8918"
        
        view.backgroundColor = .black
        presenter?.didTriggerViewReadyEvent()
        setupConstraints()
        setupTableView()
    }
}


extension MainScreenViewController: MainScreenView {
    func setupConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    func registerCells() {
        tableView.register(ScrollableMoviesTableViewCell.self,
                           forCellReuseIdentifier: "ScrollableMoviesTableViewCell")
    }
    
    func getPopularCell(indexPath: IndexPath) -> ScrollableMoviesTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollableMoviesTableViewCell", for: indexPath) as? ScrollableMoviesTableViewCell else { return ScrollableMoviesTableViewCell() }
        guard let popularMovies = presenter?.getPopularMovies() else { return cell }
        
        let viewModelItems = popularMovies.map {
            ScrollableMoviesTableViewCell.ViewModel.Item(
                image: UIImage(data: $0.imageData ?? Data()) ?? UIImage(),
                title: $0.title ?? "",
                description: $0.description ?? ""
            )
        }
        
        cell.configure(viewModel: .init(items: viewModelItems))
        
        return cell
    }
    
    func getTvShowsCell(indexPath: IndexPath) -> ScrollableMoviesTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollableMoviesTableViewCell", for: indexPath) as? ScrollableMoviesTableViewCell else { return ScrollableMoviesTableViewCell() }
        guard let tvShowsMovies = presenter?.getTvShowsMovies() else { return cell }
        
        let viewModelItems = tvShowsMovies.map { ScrollableMoviesTableViewCell.ViewModel.Item(
            image: UIImage(data: $0.imageData ?? Data()) ?? UIImage(),
            title: $0.title ?? "",
            description: $0.description ?? ""
        )
        }
        
        cell.configure(viewModel: .init(items: viewModelItems))
        
        return cell
    }
    
    
    func getContinueWatchingCell(indexPath: IndexPath) -> ScrollableMoviesTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollableMoviesTableViewCell", for: indexPath) as? ScrollableMoviesTableViewCell else { return ScrollableMoviesTableViewCell() }
        guard let continueMovies = presenter?.getContinueMovies() else { return cell }
        
        let viewModelItems = continueMovies.map { ScrollableMoviesTableViewCell.ViewModel.Item(
            image: UIImage(data: $0.imageData ?? Data()) ?? UIImage(),
            title: $0.title ?? "",
            description: $0.description ?? ""
        ) }
        
        cell.configure(viewModel: .init(items: viewModelItems))
        
        return cell
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            return getPopularCell(indexPath: indexPath)
        case (1,0):
            return getTvShowsCell(indexPath: indexPath)
        case (2,0):
            return getContinueWatchingCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            return "Popular Films"
        case 1:
            return "TV Show"
        case 2:
            return "Continue watching"
        default:
            return nil
        }
    }
}
