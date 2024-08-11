//
//  PlacesMap.swift
//  ZoneMaze
//
//  Created by Ali AI on 12/28/23.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation


final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 0, longitude: 0),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    
    func setup() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}

struct Place: Identifiable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct PlacesMap: View {
    @State private var region = MKCoordinateRegion(
            center: .init(latitude: 37.334_900,longitude: -122.009_020),
            span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    
    @State var locationManager = CLLocationManager()
    @StateObject var manager = LocationManager()
    
    @State private var places: [Place] = []
    @State var completer = MKLocalSearchCompleter()

    
    private func searchPlacesWithKeyword(_ keyword: String) {
          let request = MKLocalSearch.Request()
          request.naturalLanguageQuery = keyword
        request.region = manager.region

          let search = MKLocalSearch(request: request)
          search.start { response, error in
              guard let response = response else {
                   return
              }

              places = response.mapItems.map {
                  Place(
                      name: $0.name ?? "Unknown",
                      coordinate: $0.placemark.coordinate
                  )
              }

              if let firstPlace = places.first {
                  region.center = firstPlace.coordinate
              }
          }
      }

    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    Text("Cool places in your area")
                        .bold()
                        .font(.system(size: 23))
                    Spacer()
                }.padding()
                
                if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
                    Map(coordinateRegion: $manager.region, showsUserLocation: true, annotationItems: places) { place in
                        MapPin(coordinate: place.coordinate, tint: .blue)
                    }                        .frame(width: 350, height: 375)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding()
                        .onAppear {
                            locationManager.requestWhenInUseAuthorization()
                            searchPlacesWithKeyword("park")
                        }
                    
                } else {
                    Text("Sorry, you need to enable location services to use this feature.")
                        .frame(width: 350, height: 375)
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                        .padding()
                }

               
            }

        
    }
}
