//
//  APIError.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

struct APIError: Error, Decodable {
    var message: String?
    var code: Int?
}
