//
//  MapView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import SwiftUI
import MapKit
import Alamofire

struct MapView: UIViewRepresentable {
    @ObservedObject var SelectedMapAddress: AddressObservable
    var mMap: MKMapView
    
    init(map: MKMapView, selectedMapAddress: AddressObservable) {
        self.mMap = map
        self.SelectedMapAddress = selectedMapAddress
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self.mMap, self.SelectedMapAddress)
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
    @ObservedObject var SelectedMapAddress: AddressObservable
    
    init (_ map: MKMapView, _ selectedMapAddress: AddressObservable) {
        self.mMap = map
        self.SelectedMapAddress = selectedMapAddress
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        //var icon = UIImage(named: "map-marker-alt")?.withTintColor(UIColor.red)
        //annotationView.image = icon?.resize(to: CGSize(width: 25, height: 30))
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        annotationView.glyphImage = UIImage(named: "iconmonstr-flag")
        annotationView.glyphTintColor = UIColor.darkGray
        annotationView.markerTintColor = UIColor.clear
        annotationView.clusteringIdentifier = "annotation"
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
        self.setAddressMarker(coordinate)
    }
    
    func setAddressMarker(_ coordinate: CLLocationCoordinate2D){
        let url = "https://nominatim.openstreetmap.org/reverse"
        try AF.request(url, method: .get, parameters: ["lat": String(coordinate.latitude), "lon": String(coordinate.longitude), "format": "json", "accept-languange": "ru"], headers: [.userAgent("autorent/1.0")]).responseJSON { response in
            var address: autorent.Address?
            if response.value != nil {
                let jsonElement = (response.value as! [String:Any])["address"]
                let jsonData = try? JSONSerialization.data(withJSONObject: jsonElement!, options: .prettyPrinted)
                let addressModel = try! JSONDecoder().decode(MapAddressModel.self, from: jsonData!)
                address = addressModel.convertToAddress()
                self.SelectedMapAddress.Address = address
            }
            let marker = MKPointAnnotation()
            marker.coordinate = coordinate
            marker.title = address != nil ? address!.getAddressName() : NSLocalizedString("message_address_error", comment: "")
            marker.subtitle = nil
            self.mMap.removeAnnotations(self.mMap.annotations)
            self.mMap.addAnnotation(marker)
        }
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
