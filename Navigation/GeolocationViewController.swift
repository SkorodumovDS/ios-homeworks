//
//  GeolocationViewController.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 09.11.2023.
//


import UIKit
import MapKit
import CoreLocation

class GeolocationViewController: UIViewController {
    
    var destination : MKAnnotation? = nil
    var myLocation : MKAnnotation? = nil
    
    private lazy var mapView: MKMapView = {
        let mapkit = MKMapView()
        mapkit.delegate = self
        mapkit.showsUserLocation = true
        if #available(iOS 17.0, *) {
            mapkit.showsUserTrackingButton = true
        } else {
        }
        mapkit.translatesAutoresizingMaskIntoConstraints = false
        return mapkit
    }()
    
    private lazy var segment: UISegmentedControl  = {
        let newSegment = UISegmentedControl()
        newSegment.insertSegment(withTitle: "Standart".localized(), at: 0, animated: true)
        newSegment.insertSegment(withTitle: "Satelite".localized(), at: 1, animated: true)
        newSegment.insertSegment(withTitle: "Hybrid".localized(), at: 2, animated: true)
        newSegment.selectedSegmentIndex = 0
        newSegment.backgroundColor = .systemBackground
        newSegment.translatesAutoresizingMaskIntoConstraints = false
        newSegment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return newSegment
    }()
    
    private lazy var clearButton : UIButton  = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("clear points".localized(), for: .normal)
        button.addTarget(self, action: #selector(ClearPoints), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var routeButton : UIButton  = {
       let button = UIButton()
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Route".localized(), for: .normal)
        button.addTarget(self, action: #selector(GetRoute), for: .touchUpInside)
        
        return button
    }()
    
    let locationMan = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMan.requestWhenInUseAuthorization()
        locationMan.startUpdatingLocation()
        locationMan.delegate = self
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        mapView.addGestureRecognizer(longPressGesture)
        view.addSubview(mapView)
        view.addSubview(segment)
        view.addSubview(clearButton)
        view.addSubview(routeButton)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 0.0
            ),
            mapView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: 0.0
            ),
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            segment.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 0),
            segment.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: 0),
            segment.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -5),
            segment.heightAnchor.constraint(equalToConstant: 50),
            
            clearButton.leadingAnchor.constraint(equalTo: segment.leadingAnchor, constant: 0),
            clearButton.widthAnchor.constraint(equalToConstant: 150),
            clearButton.bottomAnchor.constraint(equalTo: segment.topAnchor, constant: -5),
            clearButton.heightAnchor.constraint(equalToConstant: 40),
            
            routeButton.trailingAnchor.constraint(equalTo: segment.trailingAnchor, constant: 0),
            routeButton.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: segment.topAnchor, constant: -5),
            routeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = .standard
            
        case 1:
            self.mapView.mapType = .satellite
            
        case 2:
            self.mapView.mapType = .hybrid
            
        default:
            self.mapView.mapType = .standard
        }
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        let point = sender.location(in: self.mapView)
        let coordinate = self.mapView.convert(point, toCoordinateFrom: self.mapView)
        
        addAnnotation(coordinates: coordinate, title: "newPoint".localized())
    }
    
    @objc func ClearPoints(sender: UILongPressGestureRecognizer) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        let overlays = self.mapView.overlays
        self.mapView.removeOverlays(overlays)
    }
    
    @objc func GetRoute(sender: UILongPressGestureRecognizer) {
        guard let destination , let myLocation else {return}
        
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: myLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.coordinate))
        
        let direction  = MKDirections(request: request)
        
        direction.calculate{ response, error in
            if let response, let route = response.routes.first {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func addAnnotation(coordinates: CLLocationCoordinate2D , title : String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = title
        self.mapView.addAnnotation(annotation)
        self.destination = annotation
    }
}

extension GeolocationViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = locations.first!.coordinate
        annotation.title = "MyLocation".localized()
        self.myLocation = annotation
    }
}

extension GeolocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render  = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 5
            return render
        }
        return MKPolylineRenderer()
    }
}
