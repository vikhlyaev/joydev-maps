//
//  MapViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    // MARK: Properties
    
    private let viewModel: MapOutput
    
    // MARK: Life Cycle
    
    init(viewModel: MapOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemBlue
        view.addSubview(map)
    }
}

// MARK: - Setting Constraints

private extension MapViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makeMapScreen()
}

