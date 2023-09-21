//
//  PlaceDetailsViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class PlaceDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    private let presenter: PlaceDetailsOutput
    
    // MARK: Life Cycle
    
    init(presenter: PlaceDetailsOutput) {
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
        presenter.viewIsReady()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemOrange
    }
}

// MARK: - PlaceDetailsInput

extension PlaceDetailsViewController: PlaceDetailsInput {
    
}

// MARK: - Setting Constraints

extension PlaceDetailsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makePlaceDetailsScreen()
}

