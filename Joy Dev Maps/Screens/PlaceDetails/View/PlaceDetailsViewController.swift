//
//  PlaceDetailsViewController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class PlaceDetailsViewController: UIViewController {
    
    // MARK: UI
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: PlaceDetailsConstants.Name.fontSize, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        var configuration = UIButton.Configuration.gray()
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        configuration.titleAlignment = .center
        configuration.buttonSize = .large
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = PlaceDetailsConstants.Address.Title.text
        label.font = .systemFont(ofSize: PlaceDetailsConstants.Address.Title.fontSize)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        bind()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        view.addSubview(categoriesLabel)
        view.addSubview(favoriteButton)
        view.addSubview(addressTitleLabel)
        view.addSubview(addressLabel)
        
        nameLabel.text = viewModel.name
        title = viewModel.name
        categoriesLabel.text = viewModel.categories
        addressLabel.text = viewModel.address
    }
    
    // MARK: Binding
    
    private func bind() {
        viewModel.isFavorites.bind { [weak self] isFavorites in
            if isFavorites {
                self?.favoriteButton.setImage(UIImage(systemName: PlaceDetailsConstants.Button.removeFavoriteButtonImageName), for: .normal)
                self?.favoriteButton.setTitle(PlaceDetailsConstants.Button.removeFavoriteButtonText, for: .normal)
            } else {
                self?.favoriteButton.setImage(UIImage(systemName: PlaceDetailsConstants.Button.addFavoriteButtonImageName), for: .normal)
                self?.favoriteButton.setTitle(PlaceDetailsConstants.Button.addFavoriteButtonText, for: .normal)
            }
        }
        
        viewModel.imageData.bind { [weak self] imageData in
            DispatchQueue.main.async { [weak self] in
                self?.photoImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: Actions
    
    @objc
    private func favoriteButtonTapped() {
        viewModel.favoriteButtonTapped()
    }
}

// MARK: - Setting Constraints

private extension PlaceDetailsViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: PlaceDetailsConstants.Photo.height),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: PlaceDetailsConstants.Name.topInset),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlaceDetailsConstants.Name.leftRightInsets),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlaceDetailsConstants.Name.leftRightInsets),
            
            categoriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: PlaceDetailsConstants.Categories.topInset),
            categoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlaceDetailsConstants.Categories.leftRightInsets),
            categoriesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlaceDetailsConstants.Categories.leftRightInsets),
            
            favoriteButton.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: PlaceDetailsConstants.Button.topInset),
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlaceDetailsConstants.Button.leftRightInsets),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlaceDetailsConstants.Button.leftRightInsets),
            
            addressTitleLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: PlaceDetailsConstants.Address.Title.topInset),
            addressTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlaceDetailsConstants.Address.Title.leftRightInsets),
            addressTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlaceDetailsConstants.Address.Title.leftRightInsets),
            
            addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: PlaceDetailsConstants.Address.Value.topBottomInsets),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PlaceDetailsConstants.Address.Value.leftRightInsets),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PlaceDetailsConstants.Address.Value.leftRightInsets)
        ])
    }
}
