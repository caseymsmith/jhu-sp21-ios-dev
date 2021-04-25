//
//  MapView.swift
//  Borrow
//
//  Created by Casey on 2/21/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var city = Array<String>.init(repeating: "Downtown San Diego", count: 1)
    @State private var coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    init() {

        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    //TODO: put onclick on text field for location
                    TextField("Current Location", text: $city[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading,4)
                        .padding(.trailing,-10)
                    NavigationLink(destination: ListForBorrowView()) {
                            Text("List For Borrow")
                            .fontWeight(.semibold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.orange)
                            .cornerRadius(15)
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 50, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                Map(coordinateRegion: $coordinateRegion)
                    .frame(width: 350, height: 400, alignment: .center)
                Text("Products List Here")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
