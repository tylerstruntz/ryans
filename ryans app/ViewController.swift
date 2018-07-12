//
//  ViewController.swift
//  ryans app
//
//  Created by Tyler Struntz on 7/11/18.
//  Copyright © 2018 Tyler Struntz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate
{
   
    @IBOutlet weak var placesMap: MKMapView!
    let locationManager:CLLocationManager = CLLocationManager()
    override func viewDidLoad()
    {
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "locationArray") != nil
        {
            for dictionary in UserDefaults.standard.object(forKey: "locationArray") as! [[String:Double]]
            {
                let center = CLLocationCoordinate2D(latitude: dictionary["latitude"]!, longitude: dictionary["longitude"]!)
                let annotation = MKPointAnnotation()
                annotation.coordinate = center
                self.placesMap.addAnnotation(annotation)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
        self.placesMap?.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
        
        let locationDictionary:[String:Double] = ["latitidue":center.latitude, "longitude":center.longitude]
        var locationArray = [[String:Double]]()
        if UserDefaults.standard.object(forKey: "locationArray") != nil
        {
            locationArray = UserDefaults.standard.object(forKey: "locationArray") as! [[String:Double]]
        }
        
        locationArray.append(locationDictionary)
        UserDefaults.standard.set(locationArray, forKey: "locationArray")
        UserDefaults.standard.synchronize()
        
//        var myLocation:CLLocationCoordinate2D?
//
//        for currentLocations in locations
//        {
//            //print("\(index): \(locations)")
//
//            print("---------------------------")
//            var x = locations.last?.coordinate.latitude
//            var y = locations.last?.coordinate.longitude
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("error code: " + error.localizedDescription)
    }
    
    @IBAction func addButton(_ sender: AnyObject)
    {
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

