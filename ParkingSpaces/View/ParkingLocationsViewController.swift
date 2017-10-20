//
//  ViewController.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import UIKit
import MapKit
import AZDialogView

protocol ParkingLocationsView {
    func showLoadingState(_ show: Bool)
    func showErrorState()
    func addLocationsToMap(_ locations: [String: ParkingLocation])
}

class ParkingLocationsViewController: UIViewController, ParkingLocationsView {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var presenter = ParkingLocationsPresenter(withClient: LocationsClient())
    var locations: [String: ParkingLocation]?

    var loadingDialog: AZDialogViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initMap()
        
        presenter.view = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.loadLocations()
    }
    
    // MARK: Private
    
    private func initMap() {
        let mapCenter = CLLocationCoordinate2D(latitude: CLLocationDegrees(51.5560241), longitude: CLLocationDegrees(-0.2817075))
        let mapEyeDistance = CLLocationDistance(5000)
        let camera = MKMapCamera(lookingAtCenter: mapCenter, fromEyeCoordinate: mapCenter, eyeAltitude: mapEyeDistance)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setCamera(camera, animated: false)
    }
    
    private func addMapAnnotation(forLocation location: ParkingLocation) {
        if let lat = location.lat, let lng = location.lng {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            annotation.title = "\(location.id ?? 0)"
            mapView.addAnnotation(annotation)
        }
    }
    
    // MARK: View
    
    func showLoadingState(_ show: Bool) {
        if show {
            loadingDialog = AZDialogViewController(title: "Loading")
            loadingDialog?.dismissWithOutsideTouch = false
            loadingDialog?.customViewSizeRatio = 0.1
            
            if let container = loadingDialog?.container {
                let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                container.addSubview(indicatorView)
                
                indicatorView.translatesAutoresizingMaskIntoConstraints = false
                indicatorView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
                indicatorView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
                indicatorView.startAnimating()
            }
            
            loadingDialog?.show(in: self)
        } else {
            loadingDialog?.dismiss()
        }
    }
    
    func addLocationsToMap(_ locations: [String: ParkingLocation]) {
        self.locations = locations
        for (_, location) in locations {
            addMapAnnotation(forLocation: location)
        }
    }
    
    func showErrorState() {
        let errorDialog = AZDialogViewController(title: "Error", message: "Better luck next time!")
        errorDialog.dismissWithOutsideTouch = false
        errorDialog.show(in: self)
    }

}

extension ParkingLocationsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        // Create or reuse annotation view
        let annotationReuseId = "MKAnnotationViewReuseIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationReuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
            
            let marker = MarkerView.loadFromNib()
            marker.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            marker.isUserInteractionEnabled = false
            
            annotationView?.addSubview(marker)
            annotationView?.frame = marker.frame
        } else {
            annotationView?.annotation = annotation
        }
        
        // Get subview, data and populate it
        if let markerView = annotationView?.subviews[0] as? MarkerView {
            guard let annotationTitle = annotationView?.annotation?.title, let locationId = annotationTitle else { return nil }
            guard let location = locations?[locationId] else { return nil }
            
            if let price = location.pricePerDay, let currency = location.currency {
                markerView.label.text = "\(price.rounded(toPlaces: 1))\n\(currency)"
            }
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationTitle = view.annotation?.title, let locationId = annotationTitle else { return }
        guard let location = locations?[locationId] else { return }
        
        let popup = LocationInfoPopupViewController(nibName: "LocationInfoPopupView", bundle: nil)
        popup.location = location
        popup.modalPresentationStyle = .overCurrentContext
        
        present(popup, animated: true, completion: { [weak self] in
            guard let welf = self else { return }
            popup.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: welf, action: #selector(welf.dismissAlert(_:))))
        })
    }
    
    func dismissAlert(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
