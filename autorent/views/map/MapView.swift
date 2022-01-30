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
    @ObservedObject var CurrentMapAddress: AddressObservable
    @ObservedObject var SelectedMapAddress: AddressObservable
    var mMap: MKMapView
    @Binding var ActionMode: Int?
    
    init(map: MKMapView, currentMapAddress: AddressObservable, mode: Binding<Int?>, selectedMapAddress: AddressObservable) {
        self.mMap = map
        self.CurrentMapAddress = currentMapAddress
        self._ActionMode = mode
        self.SelectedMapAddress = selectedMapAddress
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self.mMap, $ActionMode, self.SelectedMapAddress)
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
        if self.CurrentMapAddress.Address != nil {
            self.selectAddress(self.CurrentMapAddress.Address!.getAddressName())
        }
        return self.mMap
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func selectAddress(_ addressName: String) {
        let url = "https://nominatim.openstreetmap.org/search"
        try AF.request(url, method: .get, parameters: ["format": "json", "accept-languange": "ru", "addressdetails": "1", "limit": "10", "q": addressName], headers: [.userAgent("autorent/1.0")]).responseJSON { response in
            if response.data != nil {
                let jsonData = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                let items = (jsonData as! NSArray)
                if items.count > 0 {
                    let jsonElement = (items[0] as! NSDictionary)["address"]
                    let jsonData = try? JSONSerialization.data(withJSONObject: jsonElement!, options: .prettyPrinted)
                    let addressModel = try! JSONDecoder().decode(MapAddressModel.self, from: jsonData!)
                    let address = addressModel.convertToAddress()
                    let marker = MKPointAnnotation()
                    let lat = Double((items[0] as! NSDictionary)["lat"] as! String)
                    let lon = Double((items[0] as! NSDictionary)["lon"] as! String)
                    marker.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
                    marker.title = address.getAddressName()
                    marker.subtitle = nil
                    self.mMap.removeAnnotations(self.mMap.annotations)
                    self.mMap.addAnnotation(marker)
                }
            }
        }
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    var mMap: MKMapView
    @Binding var ActionMode: Int?
    @ObservedObject var SelectedMapAddress: AddressObservable
    
    init (_ map: MKMapView, _ mode: Binding<Int?>, _ selectedMapAddress: AddressObservable) {
        self.mMap = map
        self._ActionMode = mode
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
        if self.ActionMode == 1 {
            let location = gesture.location(in: self.mMap)
            let coordinate = self.mMap.convert(location, toCoordinateFrom: self.mMap)
            self.selectAddress(coordinate)
        }
    }
    
    func selectAddress(_ coordinate: CLLocationCoordinate2D) {
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
