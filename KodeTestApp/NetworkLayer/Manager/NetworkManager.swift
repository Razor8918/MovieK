//
//  NetworkManager.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

import Foundation

protocol NetworkGatewayProtocol: AnyObject {
    var session: URLSession { get }
    
    func dataTask<T:Decodable> (
        with request: URLRequest,
        decodeType: T.Type,
        completion: @escaping(Result<T?, APIError>) -> Void)
}

// MARK: - DataTask

extension NetworkGatewayProtocol {
    func dataTask<T: Decodable>(
        with request: URLRequest,
        decodeType: T.Type,
        completion: @escaping (Result<T?, APIError>) -> Void) {
            session.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async { [weak self] in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(APIError()))
                        return
                    }
                    
                    let statusCode = httpResponse.statusCode
                    
                    guard statusCode == 200 else {
                        completion(.failure(APIError(code: statusCode)))
                        return
                    }
                    
                    if let data = data,
                       let genericModel = self?.decodeData(data: data, decodingType: decodeType.self) {
                        completion(.success(genericModel))
                    } else {
                        completion(.failure(APIError(code: statusCode)))
                    }
                }
            }
        }
}

// MARK: - Private Methods

private extension NetworkGatewayProtocol {
    func decodeData<T>(
        data: Data,
        decodingType: T.Type) -> T? where T : Decodable {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                debugPrint(error)
                return nil
            }
        }
}
