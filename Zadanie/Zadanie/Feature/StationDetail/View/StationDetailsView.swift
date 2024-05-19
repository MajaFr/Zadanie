//
//  StationDetailsView.swift
//  Zadanie
//
//  Created by Maja Frąk on 16/05/2024.
//

import UIKit
import MapKit

class StationDetailsView: UIView {
    
    @UsesAutoLayout
    var mapView = MKMapView().then {
        $0.showsUserLocation = true
    }
    
    @UsesAutoLayout
    var stationDetailView = StationDetailView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @UsesAutoLayout
    var bottomSeparatoView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mapView.delegate = self
        addSubviews()
        setupSubviews()
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let userLocation = MKPointAnnotation()
        userLocation.title = "userLocation"
        userLocation.coordinate = pickupCoordinate
        mapView.addAnnotation(userLocation)
        
        let bikeStation = MKPointAnnotation()
        bikeStation.title = "bikeStation"
        bikeStation.coordinate = destinationCoordinate
        mapView.addAnnotation(bikeStation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        MKDirections(request: request).calculate { [weak self] response, error in
            guard let route = response?.routes.first else { return }
            
            self?.mapView.addOverlay(route.polyline)
            self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 100.0, bottom: 300.0, right: 100.0), animated: true)
        }
    }
    
    func adapt(model: DisplayableStation) {
        stationDetailView.titleLabel.text = model.name
        stationDetailView.firstSubTitleLabel.text = "\(model.distance) m"
        stationDetailView.placesAvailableValueLabel.text = String(model.placesAvailable)
        stationDetailView.bikesAvailableValueLabel.text = String(model.bikesAvailable)
        stationDetailView.secoundSubTitleLabel.text = model.address
    }
    
    private func addSubviews() {
        [mapView, stationDetailView, bottomSeparatoView].forEach {
            addSubview($0)
        }
    }
    
    private func setupSubviews() {
        mapViewSetup()
    }
    
    private func mapViewSetup() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stationDetailView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stationDetailView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stationDetailView.bottomAnchor.constraint(equalTo: bottomSeparatoView.topAnchor),
            
            bottomSeparatoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparatoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparatoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparatoView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension StationDetailsView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.distanceLine
        renderer.lineWidth = 2.0
        renderer.lineCap = .square
        renderer.lineDashPattern = [4,8]
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            annotationView?.annotation = annotation
        }
        
        let annotationImage = switch annotation.title {
        case "bikeStation": AppImages.bike
        case "userLocation": AppImages.location
        default: UIImage()
        }
        
        annotationView?.image = annotationImage
        return annotationView
    }
}
