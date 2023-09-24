//
//  AuthViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AuthConstants.logoImageViewImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var authParamsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.bounces = false
        tableView.register(AuthCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .systemGreen
        configuration.baseForegroundColor = .systemGreen
        configuration.buttonSize = .large
        configuration.title = AuthConstants.loginButtonText
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Properties
    
    private let viewModel: AuthOutput
    
    // MARK: Life Cycle
    
    init(viewModel: AuthOutput) {
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
        bind()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        view.addSubview(authParamsTableView)
        view.addSubview(errorLabel)
        view.addSubview(loginButton)
    }
    
    // MARK: Binding
    
    private func bind() {
        viewModel.errorText.bind { [weak self] text in
            self?.errorLabel.text = text
        }
    }
    
    // MARK: Actions
    
    @objc
    private func loginButtonTapped() {
        let currentLogin = (authParamsTableView.visibleCells[0] as? AuthCell)?.textField.text ?? ""
        let currentPassword = (authParamsTableView.visibleCells[1] as? AuthCell)?.textField.text ?? ""
        viewModel.loginButtonTapped(login: currentLogin, password: currentPassword)
    }
}

// MARK: - UITableViewDataSource

extension AuthViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AuthCell = tableView.dequeueReusableCell()
        cell.configure(with: viewModel.parameterForRowAt(indexPath: indexPath))
        cell.textField.tag = indexPath.row
        cell.textField.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate

extension AuthViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AuthConstants.TableView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(
            top: 0,
            left: AuthConstants.TableView.leftRigthInsets,
            bottom: 0,
            right: AuthConstants.TableView.leftRigthInsets
        )
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = view.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        errorLabel.text = ""
    }
}

// MARK: - Setting Constraints

private extension AuthViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: AuthConstants.Logo.topInset),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: AuthConstants.Logo.widthHeight),
            logoImageView.heightAnchor.constraint(equalToConstant: AuthConstants.Logo.widthHeight),
            
            authParamsTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: AuthConstants.TableView.topInset),
            authParamsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authParamsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authParamsTableView.heightAnchor.constraint(equalToConstant: AuthConstants.TableView.cellHeight * CGFloat(AuthParameters.allCases.count)),
            
            errorLabel.topAnchor.constraint(equalTo: authParamsTableView.bottomAnchor, constant: AuthConstants.Error.topInset),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.Error.leftRigthInsets),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.Error.leftRigthInsets),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AuthConstants.LoginButton.bottomInset),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.LoginButton.leftRightInsets),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.LoginButton.leftRightInsets)
        ])
    }
}


// MARK: - Preview

#Preview {
    ScreenAssemblyImpl().makeAuthScreen()
}
