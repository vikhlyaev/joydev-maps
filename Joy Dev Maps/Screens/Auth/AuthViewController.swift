//
//  AuthViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: Properties
    
    private let presenter: AuthOutput
    
    // MARK: Life Cycle
    
    init(presenter: AuthOutput) {
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
        view.backgroundColor = .systemRed
    }
}

// MARK: - AuthInput

extension AuthViewController: AuthInput {
    
}

// MARK: - Setting Constraints

extension AuthViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}


// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makeAuthScreen()
}
