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
        map.isRotateEnabled = false
        map.delegate = self
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = MapConstants.SearchTextField.placeholderText
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemBackground
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: textField.bounds.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.addShadow()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var myLocationButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: MapConstants.MyLocationButton.imageName)
        configuration.baseBackgroundColor = .systemBackground
        configuration.baseForegroundColor = .systemBlue
        configuration.buttonSize = .large
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.addShadow()
        button.addTarget(self, action: #selector(myLocationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        bind()
    }
    
    // MARK: Setup UI
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(map)
        view.addSubview(searchTextField)
        view.addSubview(myLocationButton)
    }
    
    // MARK: Binding
    
    private func bind() {
        viewModel.annotations.bind { [weak self] annotations in
            guard let self else { return }
            map.removeAnnotations(map.annotations)
            map.addAnnotations(annotations)
        }
        
        viewModel.userLocation.bind { [weak self] userLocation in
            self?.setRegion(userLocation.coordinate)
        }
        
        viewModel.lastLocation.bind { [weak self] lastLocation in
            self?.setRegion(lastLocation.coordinate)
        }
    }
    
    // MARK: Private functions
    
    private func setRegion(_ coordinates: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        map.setRegion(region, animated: true)
    }
    
    // MARK: Actions
    
    @objc
    private func myLocationButtonTapped() {
        viewModel.requestUserLocation()
    }
}

// MARK: - UITextFieldDelegate

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.getPlace(with: textField.text ?? "")
        textField.endEditing(true)
        return true
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        let view: MKMarkerAnnotationView
        let identifier = "place"
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard 
            let view = view.annotation as? PlaceAnnotation,
            let id = view.id,
            let place = viewModel.viewAnnotationTapped(id: id)
        else { return }
        let vc = ScreenAssembly.shared.makePlaceDetailsScreen(with: place)
        present(vc, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.didUpdateCenterCoordinate(mapView.region.center)
        searchTextField.endEditing(true)
    }
}

// MARK: - Setting Constraints

private extension MapViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MapConstants.SearchTextField.topInset),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MapConstants.SearchTextField.leftRightInsets),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MapConstants.SearchTextField.leftRightInsets),
            searchTextField.heightAnchor.constraint(equalToConstant: MapConstants.SearchTextField.height),
            
            myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MapConstants.MyLocationButton.rightInset),
            myLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -MapConstants.MyLocationButton.bottomInset)
        ])
    }
}
