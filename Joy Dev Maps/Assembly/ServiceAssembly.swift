//
//  ServiceAssembly.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 24.09.2023.
//

import Foundation

protocol ServiceAssembly {
    func makePlaceService() -> PlaceService
    func makeUserLocationService() -> UserLocationService
    func makeLastLocationService() -> LastLocationService
}

// MARK: - Implementation

final class ServiceAssemblyImpl: ServiceAssembly {
    
    // MARK: Properties
    
    private let networkService: NetworkService = NetworkServiceImpl()
    
    // MARK: ServiceAssembly
    
    func makePlaceService() -> PlaceService {
        PlaceServiceImpl(networkService: networkService)
    }
    
    func makeUserLocationService() -> UserLocationService {
        UserLocationServiceImpl()
    }
    
    func makeLastLocationService() -> LastLocationService {
        LastLocationServiceImpl()
    }
}
