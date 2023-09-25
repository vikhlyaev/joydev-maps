//
//  NetworkService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

protocol NetworkService {
    func fetch(for request: URLRequest, _ completion: @escaping (Result<Data, Error>) -> Void)
}

// MARK: - Implementation

final class NetworkServiceImpl: NetworkService {
    
    // MARK: Properties
    
    private let session = URLSession.shared
    
    // MARK: NetworkService
    
    func fetch(for request: URLRequest, _ completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request, completionHandler: { data, response, error in
            if let data, let response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    completion(.success(data))
                } else {
                    completion(.failure(NetworkError.httpStatusCode(statusCode)))
                }
            } else if let error {
                completion(.failure(NetworkError.urlRequestError(error)))
            } else {
                completion(.failure(NetworkError.urlSessionError))
            }
        }).resume()
    }
}

// MARK: - Network Error

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
