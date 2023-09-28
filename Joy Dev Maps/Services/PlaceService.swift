//
//  PlaceService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 24.09.2023.
//

import Foundation

protocol PlaceService {
    func getPlaces(by query: String, and coordinate: LocationCoordinate, _ completion: @escaping (Result<[Place], Error>) -> Void)
}

// MARK: - Implementation

final class PlaceServiceImpl: PlaceService {
    
    // MARK: Properties
    
    private let networkService: NetworkService
    
    // MARK: Life Cycle
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    
    // MARK: Private functions
    
    private func prepareRequest(with query: String, and coordinate: LocationCoordinate) -> URLRequest? {
        guard
            let host = Bundle.main.object(forInfoDictionaryKey: "URL Host") as? String,
            let path = Bundle.main.object(forInfoDictionaryKey: "URL Path") as? String,
            let apiKey = Bundle.main.object(forInfoDictionaryKey: "API Key") as? String
        else { return nil }
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "ll", value: "\(coordinate.latitude),\(coordinate.longitude)"),
            URLQueryItem(name: "open_now", value: "true"),
            URLQueryItem(name: "sort", value: "DISTANCE"),
            URLQueryItem(name: "radius", value: "100000"),
            URLQueryItem(name: "limit", value: "50")
        ]
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request.addValue("ru", forHTTPHeaderField: "Accept-Language")
        return request
    }
    
    // MARK: PlaceService
    
    func getPlaces(by query: String, and coordinate: LocationCoordinate, _ completion: @escaping (Result<[Place], Error>) -> Void) {
        let completionOnMainQueue: (Result<[Place], Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        guard let request = prepareRequest(with: query, and: coordinate) else { return }
        networkService.fetch(for: request) { results in
            switch results {
            case .success(let data):
                do {
                    let places = try JSONDecoder().decode(Places.self, from: data)
                    completionOnMainQueue(.success(places.results))
                } catch let error {
                    completionOnMainQueue(.failure(PlaceServiceError.parsingJsonError(error)))
                }
            case .failure(let error):
                completionOnMainQueue(.failure(error))
            }
        }
    }
}

// MARK: - Place Service Error

enum PlaceServiceError: Error {
    case parsingJsonError(Error)
}
