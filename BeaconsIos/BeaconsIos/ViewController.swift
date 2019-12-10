//
//  ViewController.swift
//  BeaconsIos
//
//  Created by Max Hennen on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var subjectPickerView: UIPickerView!
    
    var subjects: [Subject] = []
    var currentCompany: Company? = nil
    var companies: [Company] = []
    var showCompanies: [Company] = []


    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subjects[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subjects.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(subjects[row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        subjectPickerView.dataSource = self
        subjectPickerView.delegate = self
        subjects = Subject.allCases
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
            showCompanies.removeAll()
            _ = beacons.map{
                let beacon = $0
                _ = companies.map{
                    if $0.id == Int(truncating: beacon.minor){
                        showCompanies.append($0)
                    }
                }
            }
        } else {
            print("unknown")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCompanySegue" {
            if let destinationVC = segue.destination as? CompanyViewController {
                destinationVC.company = currentCompany
        }
    }

    func createMarket(){
        
        companies.append(Company(id: 12,name: "Kembit", website: "https://kembit.nl", subject: Subject.Software, description: "Kembit is a company from Wijnandsrade"))
        companies.append(Company(id: 2,name: "Copaco", website: "https://Copaco.nl", subject: Subject.Software, description: "Copaco is a company from Eindhoven"))
        companies.append(Company(id: 3,name: "Mediaan", website: "https://mediaan.nl", subject: Subject.Software, description: "Mediaan is a company from Heerlen"))
        companies.append(Company(id: 4,name: "Internetwerk", website: "https://internetwerk.nu", subject: Subject.Media, description: "Internetwerk is a company from Eindhoven"))
        
        _ = CompanyMarket(companies: companies)

    }
}
}
