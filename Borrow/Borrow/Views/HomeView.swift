//
//  CourseClassView.swift
//  Borrow
//
//  Created by Casey on 2/7/21.
//

import SwiftUI
import Combine
import CoreLocation
import MapKit

struct HomeView: View {
  
  @State private var userTrackingMode: MapUserTrackingMode = MapUserTrackingMode.follow
  @State private var region: MKCoordinateRegion = MKCoordinateRegion()
  @ObservedObject private var locationManager: LocationManager = LocationManager()
  
  init() {
    self.region = MKCoordinateRegion(center: locationManager.location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
  }
  
  var body: some View {
    VStack {
      Map(coordinateRegion: $region, interactionModes: [.all], showsUserLocation: true, userTrackingMode: $userTrackingMode)
      LocationInformation(locationManager: locationManager)
    }
  }

}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  
  let locationManager = CLLocationManager()
  
  @Published var location: CLLocation = CLLocation()
  
  override init() {
    super.init()
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    self.location = location
  }
  
}

struct LocationInformation: View {
  
  @StateObject var locationManager: LocationManager
  
  var body: some View {
 
    VStack {
      LocationDetailView(title: "Latitude", value: self.locationManager.location.coordinate.latitude)
      LocationDetailView(title: "Longitude", value: self.locationManager.location.coordinate.longitude)
      LocationDetailView(title: "Altitude", value: self.locationManager.location.altitude)
      LocationDetailView(title: "Vertical Accuracy", value: self.locationManager.location.verticalAccuracy)
      LocationDetailView(title: "Horizontal Accuracy", value: self.locationManager.location.horizontalAccuracy)
    }
    
  }
  
}

//fills the latitude longitude altitude etc field data
struct LocationDetailView: View {
  
  var title: String
  var value: Double
  
  var body: some View {
    HStack {
      Text(title)
      Spacer()
      Text("\(value)")
    }
  }
}

struct HomeLocationView_Previews: PreviewProvider {

  static var previews: some View {
    HomeView()
  }
}
