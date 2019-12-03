//
//  ViewController.swift
//  iBeacon
//
//  Created by Student on 03/12/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "E584FBCB-829C-48B2-88CC-F7142B926AEA")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 12, identifier: "MyBeacon")

        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
        } else {
            updateDistance(.unknown)
        }
    }

    func updateDistance(_ distance: CLProximity) {
        UIView.animate(withDuration: 0.8) {
            switch distance {
            case .far:
                self.view.backgroundColor = UIColor.blue
            case .near:
                self.view.backgroundColor = UIColor.orange
            case .immediate:
                self.view.backgroundColor = UIColor.red
            default:
                self.view.backgroundColor = UIColor.gray
            }
        }
    }
}

