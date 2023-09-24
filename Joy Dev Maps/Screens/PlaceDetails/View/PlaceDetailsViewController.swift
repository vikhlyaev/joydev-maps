//
//  PlaceDetailsViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class PlaceDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: PlaceDetailsOutput
    
    // MARK: Life Cycle
    
    init(viewModel: PlaceDetailsOutput) {
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
        view.backgroundColor = .systemOrange
    }
}

// MARK: - Setting Constraints

private extension PlaceDetailsViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makePlaceDetailsScreen()
}

