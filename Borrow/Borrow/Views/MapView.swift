//
//  MapView.swift
//  Borrow
//
//  Created by Casey on 2/21/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  
  let locationManager = CLLocationManager()
  var map = MKMapView(frame: .zero)
  var students: [Student]
  var center: Bool
  
  init(students: [Student], center: Bool) {
    self.students = students
    self.center = center
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(mapView:self)
  }
  
  func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
    
    map.delegate = context.coordinator
    
    for student in students {
      makeAnnotationForStudent(student, on: map)
    }
    
    return map
  }
  
  func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<MapView>) {
  }
  
  private func makeAnnotationForStudent(_ student: Student, on map: MKMapView) {
    
    getCoordinatesFor(student) { coord, error in
      
      let studentLocation = EPLocation(student: student, coordinate: CLLocationCoordinate2DMake(coord.latitude, coord.longitude))
      map.addAnnotation(studentLocation)
      if self.center {
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: coord, span: span)
        map.setRegion(region, animated: true)
      }
    }
  }
  
  private func getCoordinatesFor(_ student: Student, completion: @escaping (CLLocationCoordinate2D, NSError?) -> ())
  {
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(student.address, completionHandler: { placemarks, error in guard error == nil, let placemark = placemarks?[0] else {
      completion(kCLLocationCoordinate2DInvalid, error as NSError?)
      return
      }
      
      let location = placemark.location!
      completion(location.coordinate, nil)
      return
      
    })
  }
}

class Coordinator: NSObject, MKMapViewDelegate {
  
  var mapView: MapView!
  let regionRadius:CLLocationDistance = 1000.0
  @State var display = false
  
  init(mapView: MapView) {
    super.init()
    self.mapView = mapView
  }
  
  //mkannotationview
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
  {
    guard let annotation = annotation as? EPLocation else { return nil }
    
    let identifier = "pin"
    var view: MKPinAnnotationView
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
      as? MKPinAnnotationView
    {
      dequeuedView.annotation = annotation
      view = dequeuedView
    }
    else
    {
      view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      view.canShowCallout = true
      view.calloutOffset = CGPoint(x: -5, y: 5)
      view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    return view
    
  }
  
//  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
//  {
//    print("tapped callout")
//    let annotation = view.annotation as! EPLocation
//    let student = annotation.student
//
//    self.mapView.sheet(isPresented: self.$display){
//      Text("hello")
//    }
//
//    self.display.toggle()
////    let cacheItem = geocacheManager.getGeocacheItemForName(name: locationName!)
////    detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? GeocacheLocationDetailViewController
////    detailVC!.item = cacheItem
////
////
////    self.navigationController?.pushViewController(detailVC!, animated: true)
//    //can put code here to respond to disclosure button taps
//  }
  
}

class EPLocation: NSObject, MKAnnotation
{
  var title: String?
  var student: Student
  var coordinate: CLLocationCoordinate2D
  
  init(student: Student, coordinate: CLLocationCoordinate2D)
  {
    self.title = student.name
    self.student = student
    self.coordinate = coordinate
    
    super.init()
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(students: ClassAssignmentsModelTestData().students!, center: false)
  }
}
