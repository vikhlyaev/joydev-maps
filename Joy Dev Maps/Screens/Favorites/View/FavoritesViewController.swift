//
//  FavoritesViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FavoritesConstants.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Properties
    
    private let viewModel: FavoritesOutput
    
    // MARK: Life Cycle
    
    init(viewModel: FavoritesOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationController()
        setConstraints()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favoritesTableView.reloadData()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(favoritesTableView)
    }
    
    private func setupNavigationController() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: FavoritesConstants.logoutButtonText,
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
    }
    
    // MARK: Binding
    
    private func bind() {
        viewModel.isLogout.bind { isLogout in
            if isLogout {
                let vc = ScreenAssembly.shared.makeAuthScreen()
                let window = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.last { $0.isKeyWindow }
                window?.rootViewController = vc
            }
        }
    }
    
    // MARK: Actions
    
    @objc
    private func logoutButtonTapped() {
        viewModel.logout()
    }
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesConstants.reuseIdentifier, for: indexPath)
        let title = viewModel.titleForRowAt(indexPath: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = title
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let place = viewModel.selectPlaceAt(indexPath: indexPath) else { return }
        let vc = ScreenAssembly.shared.makePlaceDetailsScreen(with: place)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deletePlaceAt(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Setting Constraints

extension FavoritesViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

