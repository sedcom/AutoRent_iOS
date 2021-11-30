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

/*
class AddressMarker: NSObject, MKOverlay {
    var boundingMapRect: MKMapRect
    var coordinate: CLLocationCoordinate2D
    
    init(_ coordinate: CLLocationCoordinate2D, _ mapRect: MKMapRect) {
        self.coordinate = coordinate
        self.boundingMapRect = mapRect
    }
}
*/
/*
class AddressMarkerRender: MKOverlayRenderer {
  let overlayImage: UIImage
    
  init(overlay: MKOverlay, overlayImage: UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }

  override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
    let imageReference = overlayImage.cgImage
    let rect = self.rect(for: self.overlay.boundingMapRect)
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -rect.size.height)
    context.draw(imageReference!, in: rect)
  }
}
*/
class MapViewCoordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    var mMap: MKMapView
    
    init (_ map: MKMapView) {
        self.mMap = map
        super.init()
    }
    
    /*
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is AddressMarker {
            return AddressMarkerRender(overlay: overlay, overlayImage: UIImage(named: "map-marker-alt")!)
        }
        return MKOverlayRenderer()
    }
    */
    
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


