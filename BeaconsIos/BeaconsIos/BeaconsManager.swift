//
//  BeaconsManager.swift
//  BeaconsIos
//
//  Created by Max Hennen on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconsManager: NSObject, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    init(subject: Subject) {
        super.init()
        print("init")
        locationManager = AppDelegate().locationManager
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("authorize")
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
            print(beacons[0].proximity)
        } else {
            print("unknown")
        }
    }
    
    func createMarket(){
        
        var companies: [Company] = []
        companies.append(Company(name: "Kembit", website: NSURL(fileURLWithPath: "https://kembit.nl"), subject: Subject.Software, description: "Kembit is a company from Wijnandsrade"))
        companies.append(Company(name: "Copaco", website: NSURL(fileURLWithPath: "https://Copaco.nl"), subject: Subject.Software, description: "Copaco is a company from Eindhoven"))
        companies.append(Company(name: "Mediaan", website: NSURL(fileURLWithPath: "https://mediaan.nl"), subject: Subject.Software, description: "Mediaan is a company from Heerlen"))
        companies.append(Company(name: "Internetwerk", website: NSURL(fileURLWithPath: "https://internetwerk.nu"), subject: Subject.Media, description: "Internetwerk is a company from Eindhoven"))
        
        _ = CompanyMarket(companies: companies)

    }
}
