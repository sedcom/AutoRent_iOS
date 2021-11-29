//
//  MapView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var mMapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.7522, longitude: 37.6156), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        Map(coordinateRegion: $mMapRegion)
    }
}

struct Mapiew_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
