//
//  PlaceDetailsViewModel.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

protocol PlaceDetailsOutput {
    var name: String { get }
    var categories: String { get }
    var address: String { get }
    var imageData: Dynamic<Data> { get }
    var isFavorites: Dynamic<Bool> { get }
    func favoriteButtonTapped()
}

final class PlaceDetailsViewModel: PlaceDetailsOutput {
    
    // MARK: Properties
    
    private var place: Place
    private let favoritesService: FavoritesService
    private let placeService: PlaceService
    
    var isFavorites: Dynamic<Bool>
    var imageData: Dynamic<Data> = Dynamic(Data())
    
    // MARK: Life Cycle
    
    init(place: Place, favoritesService: FavoritesService, placeService: PlaceService) {
        self.place = favoritesService.checkIsFavorites(place: place)
        self.placeService = placeService
        self.favoritesService = favoritesService
        self.isFavorites = Dynamic(self.place.isFavorites)
        loadPhoto()
    }
    
    // MARK: Private functions
    
    private func loadPhoto() {
        self.placeService.getPhoto(by: place.id) { [weak self] results in
            switch results {
            case .success(let imageData):
                self?.imageData.value = imageData
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: PlaceDetailsOutput
    
    var name: String {
        place.name
    }
    
    var categories: String {
        place.categories.map({ $0.name }).joined(separator: ", ").capitalizedSentence
    }
    
    var address: String {
        [place.location.locality, place.location.address].compactMap({ $0 }).joined(separator: ", ")
    }
    
    func favoriteButtonTapped() {
        isFavorites.value.toggle()
        if isFavorites.value {
            place.isFavorites.toggle()
            favoritesService.addPlace(place)
        } else {
            favoritesService.removePlace(place)
        }
    }
}

