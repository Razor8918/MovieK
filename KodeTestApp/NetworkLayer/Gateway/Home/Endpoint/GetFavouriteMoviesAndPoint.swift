//
//  GetFavouriteMoviesAndPoint.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

import Foundation

struct GetFavouriteMoviesAndPoint: Endpoint {
    var path = ""
    let httpMethod: HTTPMethod = .get
    var headers: HTTPHeaders?
    var body: Encodable?
    var queryItems: [URLQueryItem]?
}
