//
//  MapViewModel.swift
//  hw6
//
//  Created by Julian Hoffmann on 05.06.23.
//

import Foundation
import MapKit
import SwiftUI


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.2083537, longitude: 16.3725042), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @Published var currentLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 48.2083537, longitude: 16.3725042)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }else{
            print("Location not accessible")
        }
    }
    
    func updateCurrentLocation() {
        guard let locationManager = locationManager else { return }
        let userLocation = locationManager.location?.coordinate
        region = MKCoordinateRegion(center: userLocation ?? CLLocationCoordinate2D(latitude: 48.2083537, longitude: 16.3725042), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else{ return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Restricted location information")
        case .denied:
            print("location information denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func bindableRegion() -> Binding<MKCoordinateRegion> {
        return Binding<MKCoordinateRegion>(get: {self.region}, set: {newValue in
            self.region = newValue
            self.currentLocation = newValue.center
        })
    }
}
