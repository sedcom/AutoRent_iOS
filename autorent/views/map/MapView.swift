//
//  MapView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let mMap = MKMapView()
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self.mMap)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 55.7522, longitude: 37.6156),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        self.mMap.setRegion(mapRegion, animated: true)
        self.mMap.delegate = context.coordinator
        let recognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(MapViewCoordinator.tapHandler(gesture:)))
        self.mMap.addGestureRecognizer(recognizer)
        return self.mMap
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    var mMap: MKMapView
    
    init (_ map: MKMapView) {
        self.mMap = map
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotationView.image = UIImage(named: "map-marker-alt")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        guard let annotation = views.first?.annotation else { return }
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    @objc func tapHandler(gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else { return }
        let location = gesture.location(in: self.mMap)
        let coordinate = self.mMap.convert(location, toCoordinateFrom: self.mMap)
        let marker = MKPointAnnotation()
        marker.coordinate = coordinate
        marker.title = "Место оказания услуг"
        marker.subtitle = "Место оказания услуг"
        self.mMap.removeAnnotations(self.mMap.annotations)
        self.mMap.addAnnotation(marker)
    }
}

struct Mapiew_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


