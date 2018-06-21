//
//  TotalViewController.swift
//  plist
//
//  Created by D7703_06 on 2018. 6. 21..
//  Copyright © 2018년 IceArrow. All rights reserved.
//

import UIKit
import MapKit

class TotalViewController: UIViewController {
    
    @IBOutlet weak var myTotalMapView: MKMapView!
    
    var address: [String] = []
    var name:[String] = []
    var annotations = [MKPointAnnotation]()
    
    // name[], type[] 배열 값 받기 위한 인덱스
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMap(address: address, name: name)
    }
    
    func  viewMap(address:[String], name:[String]) {
        for loc in address {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(loc , completionHandler: {
                (placemarks: [CLPlacemark]?, error: Error?) -> Void in
                if let error = error {
                    print(error)
                    return
                }
                
                if placemarks != nil {
                    let placemark = placemarks![0]
                    print(placemarks![0])
                    
                    // pin point 을 저장
                    let annotation = MKPointAnnotation()
                    
                    if let location = placemark.location {
                        // Add annotation
                        annotation.title = self.name[self.count]
                        annotation.subtitle = self.address[self.count]
                        self.count = self.count + 1
                        annotation.coordinate = location.coordinate
                        self.annotations.append(annotation)
                        self.myTotalMapView.addAnnotations(self.annotations)
                        
                        // Set zoom level
                        //                              let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 800, 800)
                        //                              self.totalMapView.setRegion(region, animated: true)
                    }
                }
                self.myTotalMapView.showAnnotations(self.annotations, animated: true)
            })
        }
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
