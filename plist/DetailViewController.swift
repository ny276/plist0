//
//  DetailViewController.swift
//  plist
//
//  Created by D7703_06 on 2018. 6. 21..
//  Copyright © 2018년 IceArrow. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var myMapView: MKMapView!
    
    var name = ""
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address, completionHandler: {
            (placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            if placemarks != nil {
                let placemark = placemarks![0]
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.name
                annotation.subtitle = self.address
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.myMapView.addAnnotation(annotation)
                    
                    // Set zoom level
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 700, 700)
                    self.myMapView.setRegion(region, animated: true)
                    self.myMapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
    }
}
