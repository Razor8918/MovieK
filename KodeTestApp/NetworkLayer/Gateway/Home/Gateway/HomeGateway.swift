//
//  HomeGateway.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

protocol HomeGateway {
    func getFavouriteMovies(completion: @escaping (Result<[Movie]?, APIError>) -> Void)
}
