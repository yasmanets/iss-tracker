//
//  LocationProvider.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 2/5/22.
//

import UIKit
import CoreLocation

protocol LocationProviderDelegate: AnyObject {
    func currentCoordinates(coordinates: CLLocationCoordinate2D?)
    func reverseLocation(address: String)
}

class LocationProvider: NSObject, CLLocationManagerDelegate {
    
    enum AccuracyTypes {
        case nearest
        case best
        case navigation
    }

    private let locationManager = CLLocationManager()
    private let geocoder        : CLGeocoder = CLGeocoder()

    weak var delegate:          LocationProviderDelegate?


    func enableLocation(accuracy: AccuracyTypes, viewController: UIViewController) -> Bool {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            switch accuracy {
            case .nearest:
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                break
            case .best:
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                break
            case .navigation:
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                break
            }
            self.locationManager.startUpdatingLocation()
        }
        switch self.locationManager.authorizationStatus {
        case .notDetermined:
            return false
        case .restricted, .denied:
            return false
        default:
            return true
        }
    }
    
    func disableLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    private func getReverseLocation(location: CLLocation) {
        self.geocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            if error != nil {
                self.delegate?.reverseLocation(address: "")
            }
            if let place = placemarks?.first {
                var address = ""
                if let street = place.thoroughfare {
                    address += street
                }
                if let city = place.locality {
                    address += ", \(city)"
                }
                if let postalCode = place.postalCode {
                    address += ", \(postalCode)"
                }
                if let country = place.country {
                    address += ", \(country)"
                }
                self.delegate?.reverseLocation(address: address)
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            self.delegate?.currentCoordinates(coordinates: locValue)
            
            guard let location: CLLocation = manager.location else { return }
            self.getReverseLocation(location: location)
            break
        default:
            self.delegate?.currentCoordinates(coordinates: CLLocationCoordinate2D(latitude: ApiConstants.DEFAULT_LATITUDE, longitude: ApiConstants.DEFAULT_LONGITUDE))
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.delegate?.currentCoordinates(coordinates: locValue)
        
        guard let location: CLLocation = manager.location else { return }
        self.getReverseLocation(location: location)
    }
}

