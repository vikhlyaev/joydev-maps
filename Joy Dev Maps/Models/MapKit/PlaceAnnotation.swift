//
//  PlaceAnnotation.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import UIKit
import MapKit

final class PlaceAnnotation: NSObject, MKAnnotation {
    var id: String?
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
