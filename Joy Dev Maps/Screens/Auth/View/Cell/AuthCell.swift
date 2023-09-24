//
//  AuthCell.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 22.09.2023.
//

import UIKit

final class AuthCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: Constants
    
    private enum Constants {
        static let leftRight: CGFloat = 16
    }
    
    // MARK: UI
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        contentView.addSubview(textField)
        selectionStyle = .none
    }
    
    // MARK: Configure
    
    func configure(with param: AuthParameters) {
        textField.placeholder = param.placeholder
        if param == .password {
            textField.isSecureTextEntry = true
        }
    }
}

// MARK: - Setting Constraints

private extension AuthCell {
    func setConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftRight),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftRight),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
