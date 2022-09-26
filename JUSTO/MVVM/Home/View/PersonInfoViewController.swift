//
//  PersonInfoViewController.swift
//  JUSTO
//
//  Created by Jonathan Misael Rivera on 25/09/22.
//

import Foundation
import UIKit
import MapKit
import SDWebImage

class PersonInfoViewController: UIViewController {

    @IBOutlet weak var namelLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var numberIDLabel: UILabel!
    @IBOutlet weak var mapkitView: MKMapView!
    @IBOutlet weak var profileImageView: UIImageView!

    public var viewModel: PersonInformationViewModel!
    private var loadingView: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        loadingView = createLoading()
        present(loadingView, animated: true, completion: nil)

        viewModel.getPersonInformation()
    }

    private func bind() {
        viewModel.error.observe(on: self) { [weak self] error in
            self?.loadingView?.dismiss(animated: true) {
                if let error = error {
                    print("error \(error)")
                }
            }
        }

        viewModel.requestResponse.observe(on: self) { [weak self] response in
            self?.loadingView?.dismiss(animated: true) {
                if let response = response, response == true {
                    self?.setupMapKit()
                    self?.setupUI()
                }
            }
        }
    }

    private func setupMapKit() {
        guard let latitude = viewModel.coordinates?.latitude, let _latitude = Double(latitude) else { return }
        guard let longitude = viewModel.coordinates?.longitude, let _longitude = Double(longitude) else { return }

        let location = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)

        mapkitView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location

        mapkitView.addAnnotation(annotation)
        mapkitView.layer.cornerRadius = 10
    }

    private func setupUI() {
        namelLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
        emailLabel.text = viewModel.email
        phoneLabel.text = viewModel.phone
        IDLabel.text = viewModel.ID
        numberIDLabel.text = viewModel.numberID
        profileImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

//MARK: - TODO create extension file for viewController
extension UIViewController {

    func createLoading() -> UIAlertController {
        let alertView = UIAlertController(title: "Loading...", message: "Please wait", preferredStyle: .alert)
        let loading = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loading.hidesWhenStopped = true
        loading.style = UIActivityIndicatorView.Style.medium
        loading.startAnimating();
        alertView.view.addSubview(loading)
        return alertView
    }

    static func instatiate(storyboardName: String, viewControllerIdentifier: String) -> UIViewController {
        if (Bundle.main.path(forResource: storyboardName , ofType: "storyboardc") != nil) {
            let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

            return storyboard.instantiateViewController(identifier: viewControllerIdentifier)
        } else {
            return UIViewController()
        }
    }
}

