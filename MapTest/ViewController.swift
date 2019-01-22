//
//  ViewController.swift
//  MapTest
//
//  Created by Gireesh K S on 22/01/19.
//  Copyright © 2019 -Xorbium. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    let marker = GMSMarker()
    var start:CLLocationCoordinate2D!
    var lastMapBearing:CLLocationDirection!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView.delegate = self
        // Creates a marker in the center of the map.
        start = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.icon = UIImage(named: "marker")
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = mapView
    }
    func  getBearing(begin :CLLocationCoordinate2D, end:CLLocationCoordinate2D) -> (Float){
        let lat = abs(begin.latitude - end.latitude)
        let lng = abs(begin.longitude - end.longitude)
    
        if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
            return Float(CGFloat((atan(lng / lat))) * 180 / CGFloat(Double.pi))
            
        } else if (begin.latitude >= end.latitude && begin.longitude < end.longitude) {
             return Float ((90 - CGFloat(atan(lng / lat)) * 180 / CGFloat(Double.pi)) + 90)
        } else if (begin.latitude >= end.latitude && begin.longitude >= end.longitude) {
            return Float ((CGFloat(atan(lng / lat)) * 180 / CGFloat(Double.pi)) + 180)
        } else if (begin.latitude < end.latitude && begin.longitude >= end.longitude) {
            return Float((90 - (CGFloat(atan(lng / lat)) * 180 / CGFloat(Double.pi))) + 270)
        }
        return -1
    }

}

extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        print(getBearing(begin: start, end: coordinate))
        marker.rotation = CLLocationDegrees(getBearing(begin: start, end: coordinate))
        start = coordinate
        
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        lastMapBearing = position.bearing
        marker.rotation = lastMapBearing
        print(lastMapBearing)
    }
}

