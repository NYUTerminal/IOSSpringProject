//
//  RideViewController.swift
//  RideShare
//
//  Created by praveen on 4/26/15.
//  Copyright (c) 2015 NYU. All rights reserved.
//

import Foundation


class RideViewController: UIViewController , GMSMapViewDelegate {
    
    override func viewDidLoad() {
        var camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getCurrentLocation(){
        
    }
    
    
}