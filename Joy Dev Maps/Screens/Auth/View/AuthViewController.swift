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
        imageView.image = UIImage(named: AuthConstants.Logo.imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = AuthState.allCases.map({ String($0.title) })
        let segmentControl = UISegmentedControl(items: items)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentControl
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
    
    private lazy var policyAgreementLabel: UILabel = {
        let label = UILabel()
        label.text = AuthConstants.PolicyAgreement.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var policyAgreementSwitch: UISwitch = {
        let toogler = UISwitch()
        toogler.addTarget(self, action: #selector(policyAgreementSwitchValueChanged), for: .valueChanged)
        toogler.translatesAutoresizingMaskIntoConstraints = false
        return toogler
    }()
    
    private lazy var policyAgreementStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [policyAgreementLabel, policyAgreementSwitch])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseBackgroundColor = .systemGreen
        configuration.baseForegroundColor = .systemGreen
        configuration.buttonSize = .large
        configuration.title = AuthConstants.Button.regText
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        button.isEnabled = false
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
        view.addSubview(segmentedControl)
        view.addSubview(authParamsTableView)
        view.addSubview(errorLabel)
        view.addSubview(actionButton)
        addPolicyAgreement()
        addRecognizer()
    }
    
    private func addPolicyAgreement() {
        view.addSubview(policyAgreementStackView)
        
        NSLayoutConstraint.activate([
            policyAgreementStackView.topAnchor.constraint(equalTo: authParamsTableView.bottomAnchor, constant: AuthConstants.PolicyAgreement.topInset),
            policyAgreementStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.PolicyAgreement.leftRightInsets),
            policyAgreementStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.PolicyAgreement.leftRightInsets)
        ])
    }
    
    private func removePolicyAgreement() {
        policyAgreementStackView.removeFromSuperview()
        
        NSLayoutConstraint.deactivate([
            policyAgreementStackView.topAnchor.constraint(equalTo: authParamsTableView.bottomAnchor, constant: AuthConstants.PolicyAgreement.topInset),
            policyAgreementStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.PolicyAgreement.leftRightInsets),
            policyAgreementStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.PolicyAgreement.leftRightInsets)
        ])
    }
    
    private func addRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Binding
    
    private func bind() {
        viewModel.errorText.bind { [weak self] text in
            self?.errorLabel.text = text
        }
        
        viewModel.isValidRegForm.bind { [weak self] isValid in
            guard let self else { return }
            actionButton.isEnabled = self.policyAgreementSwitch.isOn && isValid ? true : false
        }
        
        viewModel.isSuccessCheckLoginForm.bind { [weak self] isSuccess in
            self?.actionButton.isEnabled = isSuccess
        }
    }
    
    // MARK: Private functions
    
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Успешная регистрация", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func cleanForm() {
        authParamsTableView.visibleCells.forEach({ ($0 as? AuthCell)?.textField.text = "" })
        policyAgreementSwitch.setOn(false, animated: true)
    }
    
    // MARK: Actions
    
    @objc
    private func segmentControlValueChanged() {
        authParamsTableView.reloadData()
        guard let state = AuthState(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        switch state {
        case .registration:
            addPolicyAgreement()
            actionButton.setTitle(AuthConstants.Button.regText, for: .normal)
        case .login:
            removePolicyAgreement()
            actionButton.setTitle(AuthConstants.Button.loginText, for: .normal)
        }
    }
    
    @objc
    private func policyAgreementSwitchValueChanged() {
        actionButton.isEnabled = self.policyAgreementSwitch.isOn && viewModel.isValidRegForm.value ? true : false
    }
    
    @objc
    private func actionButtonTapped() {
        guard let state = AuthState(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        switch state {
        case .registration:
            let login = (authParamsTableView.visibleCells[0] as? AuthCell)?.textField.text ?? ""
            let email = (authParamsTableView.visibleCells[1] as? AuthCell)?.textField.text ?? ""
            let password = (authParamsTableView.visibleCells[2] as? AuthCell)?.textField.text ?? ""
            let user = User(login: login, email: email, password: password)
            viewModel.saveUser(user)
            cleanForm()
            showSuccessAlert()
        case .login:
            let login = (authParamsTableView.visibleCells[0] as? AuthCell)?.textField.text ?? ""
            let password = (authParamsTableView.visibleCells[1] as? AuthCell)?.textField.text ?? ""
            viewModel.login(with: login, and: password)
        }
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource

extension AuthViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = AuthState(rawValue: segmentedControl.selectedSegmentIndex) else { return 0 }
        return viewModel.numberOfRows(with: state)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let state = AuthState(rawValue: segmentedControl.selectedSegmentIndex) else { return UITableViewCell() }
        let cell: AuthCell = tableView.dequeueReusableCell()
        let parameter = viewModel.parameterForRowAt(indexPath: indexPath, with: state)
        cell.configure(with: parameter)
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
            left: AuthConstants.TableView.leftRightInsets,
            bottom: 0,
            right: AuthConstants.TableView.leftRightInsets
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
        guard let state = AuthState(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        switch state {
        case .registration:
            let login = (authParamsTableView.visibleCells[0] as? AuthCell)?.textField.text ?? ""
            let email = (authParamsTableView.visibleCells[1] as? AuthCell)?.textField.text ?? ""
            let password = (authParamsTableView.visibleCells[2] as? AuthCell)?.textField.text ?? ""
            let repeatedPassword = (authParamsTableView.visibleCells[3] as? AuthCell)?.textField.text ?? ""
            if !login.isEmpty && !email.isEmpty && !password.isEmpty && !repeatedPassword.isEmpty {
                viewModel.validateRegForm(login: login, email: email, password: password, repeatedPassword: repeatedPassword)
            }
        case .login:
            let login = (authParamsTableView.visibleCells[0] as? AuthCell)?.textField.text ?? ""
            let password = (authParamsTableView.visibleCells[1] as? AuthCell)?.textField.text ?? ""
            if !login.isEmpty && !password.isEmpty {
                viewModel.check(login: login, password: password)
            }
        }
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
            
            segmentedControl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: AuthConstants.Menu.topInset),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.Menu.leftRightInsets),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.Menu.leftRightInsets),
            
            authParamsTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: AuthConstants.TableView.topInset),
            authParamsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authParamsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authParamsTableView.heightAnchor.constraint(equalToConstant: AuthConstants.TableView.cellHeight * CGFloat(RegParameters.allCases.count)),
            
            errorLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -AuthConstants.Error.bottomInset),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.Error.leftRigthInsets),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.Error.leftRigthInsets),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AuthConstants.Button.bottomInset),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AuthConstants.Button.leftRightInsets),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AuthConstants.Button.leftRightInsets)
        ])
    }
}
