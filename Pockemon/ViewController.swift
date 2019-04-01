//
//  ViewController.swift
//  Pockemon
//
//  Created by Mike on 3/26/19.
//  Copyright © 2019 Mike. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView:GMSMapView!
    let locationManger = CLLocationManager()
    var listPockemon = [Pockemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadPockemons()
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView!
        self.mapView.delegate = self
        
        //get location
        self.locationManger.requestAlwaysAuthorization()
        self.locationManger.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
        locationManger.delegate = self;
        locationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManger.startUpdatingLocation()
            
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("Tap at -->latutude\(coordinate.latitude),longitude:\(coordinate.longitude))")
         self.listPockemon.append(Pockemon(latitude: coordinate.latitude, longitude: coordinate.longitude, image: "charmander", name: "Charmander", des: "Charmander living in japan", power: 55))
        
        for pockemon in listPockemon{
            
            if pockemon.isCatch == false{
                let markerpockemon = GMSMarker()
                markerpockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitude!, longitude: pockemon.longitude!)
                markerpockemon.title = pockemon.name!
                markerpockemon.snippet = "\(pockemon.des!), power \(pockemon.power!)"
                markerpockemon.icon = UIImage(named: pockemon.image! )
                markerpockemon.map  = self.mapView
            }
        }
    }
    
    var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocation = manager.location!.coordinate
        print("mylocation:\(myLocation)")
        self.mapView.clear()
        //my location
        let markerMe = GMSMarker()
        markerMe.position = CLLocationCoordinate2D(latitude: myLocation.latitude, longitude: myLocation.longitude)
        markerMe.title = "Mario"
        markerMe.snippet = " here is my location"
        markerMe.icon = UIImage(named: "mario")
        markerMe.map = self.mapView
        
        //show pockemons
        var index = 0
        for pockemon in listPockemon{
            
            if pockemon.isCatch == false{
            let markerpockemon = GMSMarker()
            markerpockemon.position = CLLocationCoordinate2D(latitude: pockemon.latitude!, longitude: pockemon.longitude!)
            markerpockemon.title = pockemon.name!
            markerpockemon.snippet = "\(pockemon.des!), power \(pockemon.power!)"
            markerpockemon.icon = UIImage(named: pockemon.image! )
            markerpockemon.map  = self.mapView
            
            //catch pockemon
            if (Double(myLocation.latitude).roundTo(places: 4) ==
               Double(pockemon.latitude!).roundTo(places: 4)) &&
               (Double(myLocation.longitude).roundTo(places: 4) ==
                Double(pockemon.longitude!).roundTo(places: 4)){
                listPockemon[index].isCatch = true
                AlertDialog(Pockemonpower: pockemon.power!)
                }
        }
            index = index + 1
    }
    
        
        
        let camera = GMSCameraPosition.camera(withLatitude:myLocation.latitude, longitude: myLocation.longitude, zoom: 15)
        self.mapView.camera = camera
    }
    
    var playerPower:Double = 0.0
    func LoadPockemons()  {
        self.listPockemon.append(Pockemon(latitude: -37.778999, longitude: -122.4018, image: "charmander", name: "Charmander", des: "Charmander living in japan", power: 55))
        self.listPockemon.append(Pockemon(latitude: -37.778999, longitude: -122.4018, image: "Bulbasaur", name: "Bulsabur", des: "Charmander living in japan", power: 55))
        self.listPockemon.append(Pockemon(latitude: -37.778999, longitude: -122.4018, image: "squirtle", name: "squirtle", des: "Charmander living in japan", power: 55))
    }
    
    
    func AlertDialog(Pockemonpower:Double){
        playerPower = playerPower + Pockemonpower
        let alert = UIAlertController(title: "Catch new pockemon", message: "your new power is \(playerPower)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {action in
            //code here
            print("+ one")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Double{
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

