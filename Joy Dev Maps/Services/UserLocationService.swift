//
//  UserLocationService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import Foundation
import CoreLocation

protocol UserLocationService {
    var delegate: UserLocationServiceDelegate? { get set }
    func requestUserLocation()
}

protocol UserLocationServiceDelegate: AnyObject {
    func didReceiveUserLocation(_ location: CLLocation)
}

// MARK: - Implementation

final class UserLocationServiceImpl: NSObject, UserLocationService {
    
    // MARK: Properties
    
    private let manager: CLLocationManager
    private var currentLocation: CLLocation? {
        didSet {
            guard let currentLocation else { return }
            delegate?.didReceiveUserLocation(currentLocation)
        }
    }
    
    weak var delegate: UserLocationServiceDelegate?
    
    // MARK: Life Cycle
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: UserLocationService
    
    func requestUserLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension UserLocationServiceImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.stopUpdatingLocation()
        }
    }
}


