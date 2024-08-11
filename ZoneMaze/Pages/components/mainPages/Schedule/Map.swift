//
//  Map.swift
//  ZoneMaze
//
//  Created by Ali AI on 8/9/24.
//

import Foundation
import MapKit
import SwiftUI

struct Map: UIViewRepresentable {
    var coordinates: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let mapRegion = MKCoordinateRegion(center: coordinates, span: mapSpan)
        uiView.setRegion(mapRegion, animated: true)
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = coordinates
        uiView.addAnnotation(mapAnnotation)
    }
}

func getCoordinates(from address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
    let geoC = CLGeocoder()
    geoC.geocodeAddressString(address) { placemarks, error in
        if let placemark = placemarks?.first, let location = placemark.location {
            completion(location.coordinate)
        } else {
            completion(nil)
        }
    }
}
