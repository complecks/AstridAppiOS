//
//  MapViewController.swift
//  AstridProject1
//
//  Created by Harshith Sadhu on 1/28/22.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase



class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let manager = CLLocationManager()
    var lat = Double()
    var long = Double()
    //var location = nil
    
    private let database = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        database.child("Location").observeSingleEvent(of: .value, with: {snapshot in
        
           
            
            
            
            for case let child as DataSnapshot in snapshot.children {
                    guard let dict = child.value as? [String:Any] else {
                        print("Error")
                        return
                    }
                    let latitude = dict["Latitude"] as Any
                    let longtitude = dict["Longitude"] as Any
                let Name = dict["Name"] as Any
                let Address = dict["Address"] as Any
                   
                print(longtitude)
                print(latitude)
                print(Name)
                print(Address)
                
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longtitude as! CLLocationDegrees)
                annotation.title = Name as! String
                annotation.subtitle = Address as! String
                self.mapView.addAnnotation(annotation)
                
                }
            
            
            
            
        })
            
       // let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
       // mapView.setRegion(region, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.delegate = self
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        mapView.region = MKCoordinateRegion(center: coordinate, span: span)
        
       
        
        let annotation2 = MKPointAnnotation()
    annotation2.coordinate = coordinate
    annotation2.title = "Your Location"
    mapView.addAnnotation(annotation2)

    }
    
    var selectedAnnotation: MKPointAnnotation?

    
    @IBOutlet weak var mapbtn: UIButton!
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKPointAnnotation {
            
            print("Selected")
            lat = (annotation.coordinate.latitude)
            long = (annotation.coordinate.longitude)
        }
        
        mapbtn.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view:
                    MKAnnotationView){
        print("deselected")
        mapbtn.isHidden = true
    }
    
    
    
    @IBAction func openMaps(_ sender: Any) {
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                                                            "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")! as URL)

                } else {
                    NSLog("Can't use comgooglemaps://");
                    
                    if let url = URL(string: "itms-apps://apple.com/app/id585027354") {
                        UIApplication.shared.open(url)
                    }
                    //https://apps.apple.com/us/app/google-maps/id585027354
                    
                    
                
                }
        
    }
    
    @IBOutlet weak var mapView: MKMapView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     @IBAction func h(_ sender: Any) {
     }
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
