//
//  ViewController.swift
//  BeaconsIos
//
//  Created by Max Hennen on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//
import CoreLocation
import UIKit

class ViewController: UIViewController {

    var locationManager: CLLocationManager!
    var beaconsManager: BeaconsManager!
    
    @IBOutlet weak var subjectPickerView: UIPickerView!
    @IBOutlet var table: UITableView!
    
    var subjects: [Subject] = []
    var currentCompany: Company? = nil
    var companies: [Company] = []
    var showCompanies: [Company] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconsManager = BeaconsManager(viewController: self)
        
        subjectPickerView.dataSource = self
        subjectPickerView.delegate = self
        subjects = Subject.allCases
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.table.dataSource=self
        self.table.delegate=self
    }

}

  extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        beaconsManager.authorize(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        beaconsManager.receiveBeacons(beacons: beacons)
    }
  }

  extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel!.text = self.showCompanies[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCompanies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCompany = showCompanies[indexPath.row]
        performSegue(withIdentifier: "ShowCompanySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCompanySegue" {
            if let destinationVC = segue.destination as? CompanyViewController {
                destinationVC.company = currentCompany
            }
        }
    }
  }
  
  extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
    }
  }
