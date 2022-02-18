//
//  HomeGatewayImp.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

import Foundation

final class HomeGatewayImp: NetworkGatewayProtocol {
    
    static var listingDate: Date?
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

// MARK: - HomeGatewayProtocol

extension HomeGatewayImp: HomeGateway {
    func getFavouriteMovies(completion: @escaping (Result<[Movie]?, APIError>) -> Void) {
        let endPoint = GetFavouriteMoviesAndPoint()
        
        dataTask(with: endPoint.request,
                 decodeType: [Movie].self,
                 completion: completion)
    }
}


