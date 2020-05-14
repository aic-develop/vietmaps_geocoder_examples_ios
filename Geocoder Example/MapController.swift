//
//  MapController.swift
//  Example (Swift)
//
//  Created by Phu on 5/14/20.
//  Copyright © 2020 Mapbox. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder

class MapController: UIViewController, MGLMapViewDelegate {

    var mapView: MGLMapView!
    var place: GeocodedPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        self.title = self.place?.qualifiedName ?? ""
        
        if let place = self.place,
            let location = place.location
        {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            mapView.setCenter(center, zoomLevel: 15, direction: 0, animated: false)
            
            let annotation = MGLPointAnnotation()
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
            mapView.selectAnnotation(annotation, animated: true, completionHandler: nil)
        }
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {

        // Create point to represent where the symbol should be placed
        let point = MGLPointAnnotation()
        point.coordinate = mapView.centerCoordinate

        // Create a data source to hold the point data
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: point, options: nil)

        // Create a style layer for the symbol
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)

        // Add the source and style layer to the map
        style.addSource(shapeSource)
        style.addLayer(shapeLayer)
    }

}
