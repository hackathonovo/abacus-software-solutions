//
//  MapLocationViewController.swift
//  hgss
//
//  Created by Tin Jurkovic on 21/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import AudioToolbox
import AVFoundation

class MapLocationViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var emergencyView: UIView!
    
    let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    var timer : Timer!
    var startedEmergency : Bool!
    
    var locationManager : CLLocationManager! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startedEmergency = false
        self.emergencyView.layer.cornerRadius = self.emergencyView.frame.width / 2
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        mapView.showsUserLocation = true
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        self.mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func startEmergency(_ sender: Any) {
        print("Emergency started!")
        
        if(startedEmergency){
            timer.invalidate()
            print("stopped")
            startedEmergency = false
            //Turn off torch after emergency is stopped
            if (device?.hasTorch)! {
                do {
                    try device?.lockForConfiguration()
                    
                    device?.torchMode = AVCaptureTorchMode.off

                    device?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
            
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(emergency), userInfo: nil, repeats: true)
            print("started")
            startedEmergency = true
        }
    }
    
    func emergency(){
        flashScreen()
        vibrate()
        animateButton()
        turnOnFlashLight()
        
    }
    
    func vibrate(){
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    func flashScreen(){
        var oldBrightness : CGFloat = UIScreen.main.brightness
        
        if let wnd = self.view{
            
            var v = UIView(frame: wnd.bounds)
            v.backgroundColor = UIColor.white
            v.alpha = 1
            v.isUserInteractionEnabled = false
            
            UIScreen.main.brightness = 1
            
            wnd.addSubview(v)
            
            self.emergencyView.layer.zPosition = 1.0
            
            UIView.animate(withDuration: 0.6, animations: {
                v.alpha = 0.0
            }, completion: {(finished:Bool) in
                print("inside")
                v.removeFromSuperview()
                UIScreen.main.brightness = oldBrightness
            })
        }
    }
    
    func turnOnFlashLight(){
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureTorchMode.on) {
                    device?.torchMode = AVCaptureTorchMode.off
                } else {
                    try device?.setTorchModeOnWithLevel(1.0)
                }
                device?.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func animateButton(){
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.emergencyView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.emergencyView.transform = CGAffineTransform.identity
                        }
        })
    }
    
    
}
