//
//  MapViewController.swift
//  FoodPin
//
//  Created by Rami on 12/17/18.
//  Copyright © 2018 LyfeBug. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var restaurant: RestaurantMO!

    @IBOutlet var mapView: MKMapView!

    // MARK: - MKMapViewDelegate methods

    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation)
        -> MKAnnotationView? {
            let identifier = "MyMarker"

            if annotation.isKind(of: MKUserLocation.self) {
                return nil
            }

            // Reuse the annotation if possible
            var annotationView: MKMarkerAnnotationView? =
                mapView.dequeueReusableAnnotationView(
                    withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            }
            
            annotationView?.glyphText = "😋"
            annotationView?.markerTintColor = UIColor.orange
            
            return annotationView
    }
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the map view
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location ?? "", completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }

            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]

                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type

                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
}
