//
//  MapViewModel.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation
import MapKit
import CoreLocation

protocol MapOutput {
    var userLocation: Dynamic<CLLocation> { get }
    var lastLocation: Dynamic<CLLocation> { get }
    var annotations: Dynamic<[MKAnnotation]> { get }
    var errorText: Dynamic<String> { get }
    func requestUserLocation()
    func getPlace(with searchText: String)
    func didUpdateCenterCoordinate(_ centerCoordinate: CLLocationCoordinate2D)
    func placeAt(id: String) -> Place?
}

final class MapViewModel: MapOutput {
    
    // MARK: Properties
    
    private let placeService: PlaceService
    private let userLocationService: UserLocationService
    private let lastLocationService: LastLocationService
    private let screenAssembly = ScreenAssembly.shared
    
    private var places: [Place] = []
    private var currentLocation = CLLocation() {
        didSet {
            lastLocationService.saveLastLocation(location: LocationCoordinate(
                latitude: currentLocation.coordinate.latitude,
                longitude: currentLocation.coordinate.longitude)
            )
        }
    }
    
    var errorText: Dynamic<String> = Dynamic("")
    var userLocation: Dynamic<CLLocation> = Dynamic(CLLocation())
    var lastLocation: Dynamic<CLLocation> = Dynamic(CLLocation(latitude: 55.893428, longitude: 37.655624))
    var annotations: Dynamic<[MKAnnotation]> = Dynamic([])
    
    // MARK: Life Cycle
    
    init(placeService: PlaceService, userLocationService: UserLocationService, lastLocationService: LastLocationService) {
        self.placeService = placeService
        self.userLocationService = userLocationService
        self.lastLocationService = lastLocationService
        loadLastLocation()
    }
    
    // MARK: Private functions
    
    private func saveUserLocation(_ location: CLLocation) {
        lastLocationService.saveLastLocation(location: LocationCoordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        ))
    }
    
    private func loadLastLocation() {
        if let lastLocation = lastLocationService.loadLastLocation() {
            self.lastLocation.value = CLLocation(latitude: lastLocation.latitude, longitude: lastLocation.longitude)
        }
    }
    
    // MARK: MapOutput
    
    func requestUserLocation() {
        userLocationService.requestUserLocation()
    }
    
    func getPlace(with searchText: String) {
        let location = LocationCoordinate(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        placeService.getPlaces(by: searchText, and: location) { [weak self] results in
            switch results {
            case .success(let places):
                self?.places = places
                var annotations: [MKAnnotation] = []
                places.forEach({
                    let annotation = PlaceAnnotation(coordinate: CLLocationCoordinate2D(
                        latitude: $0.geocodes.main.latitude,
                        longitude: $0.geocodes.main.longitude
                    ))
                    annotation.id = $0.id
                    annotation.title = $0.name
                    annotation.subtitle = $0.location.address
                    annotations.append(annotation)
                })
                self?.annotations.value = annotations
            case .failure(let error):
                self?.errorText.value = error.localizedDescription
            }
        }
    }
    
    func didUpdateCenterCoordinate(_ centerCoordinate: CLLocationCoordinate2D) {
        currentLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
    }
    
    func placeAt(id: String) -> Place? {
        guard let place = places.filter({ $0.id == id }).first else { return nil }
        return place
    }
}

// MARK: - UserLocationServiceDelegate

extension MapViewModel: UserLocationServiceDelegate {
    func didReceiveUserLocation(_ location: CLLocation) {
        userLocation.value = location
        saveUserLocation(location)
    }
}
