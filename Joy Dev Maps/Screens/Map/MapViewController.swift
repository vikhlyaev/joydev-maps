//
//  MapViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class MapViewController: UIViewController {
    
    // MARK: Properties
    
    private let presenter: MapOutput
    
    // MARK: Life Cycle
    
    init(presenter: MapOutput) {
        self.presenter = presenter
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
    }
}

// MARK: - MapInput

extension MapViewController: MapInput {
    
}

// MARK: - Setting Constraints

extension MapViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makeMapScreen()
}

