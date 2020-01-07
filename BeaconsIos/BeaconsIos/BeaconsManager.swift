//
//  BeaconsManager.swift
//  BeaconsIos
//
//  Created by Max Hennen on 17/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconsManager {
    
    var viewController: ViewController!
    var locationManager: CLLocationManager!
    var showCompanyViewcontroller = CompanyViewController()
    
    init(viewController: ViewController!){
        self.viewController = viewController
        locationManager = CLLocationManager()
        locationManager.delegate = self.viewController
        locationManager.requestAlwaysAuthorization()
        
        createMarket()
    }
    
    func authorize(status: CLAuthorizationStatus){
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning(){
        let uuid = UUID(uuidString: "E584FBCB-829C-48B2-88CC-F7142B926AEA")!
        let beaconRegion = CLBeaconRegion(uuid: uuid, identifier: "MyBeacon")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
    }
    
    func receiveBeacons(beacons: [CLBeacon]){
        viewController.showCompanies.removeAll()
        if beacons.count > 0 {
            for beacon in beacons {
                for company in viewController.companies {
                    if(beacon.minor.int16Value == company.id){
                        viewController.showCompanies.append(company)
                        if(beacon.accuracy <= 0.1 && viewController.currentCompany !== company){
                            if(showCompanyViewcontroller.viewIfLoaded?.window == nil){
                                viewController.currentCompany = company
                                viewController.performSegue(withIdentifier: "ShowCompanySegue", sender: viewController)
                            }
                        }
                    }
                }
            }
        }
        viewController.table.reloadData()
    }
    
    func createMarket(){
        
        viewController.companies.append(Company(id: 1,name: "Kembit", website: "https://kembit.nl", subject: Subject.Software, description: "Kembit is a company from Wijnandsrade"))
        viewController.companies.append(Company(id: 2,name: "Copaco", website: "https://Copaco.nl", subject: Subject.Software, description: "Copaco is a company from Eindhoven"))
        viewController.companies.append(Company(id: 3,name: "Mediaan", website: "https://mediaan.nl", subject: Subject.Software, description: "Mediaan is a company from Heerlen"))
        viewController.companies.append(Company(id: 4,name: "Internetwerk", website: "https://internetwerk.nu", subject: Subject.Media, description: "Internetwerk is a company from Eindhoven"))
        
        _ = CompanyMarket(companies: viewController.companies)

    }
}
