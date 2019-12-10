//
//  CompanyViewController.swift
//  BeaconsIos
//
//  Created by Student on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    @IBOutlet var CompanyNameLabel: UILabel!
    @IBOutlet var CompanyWebsiteLabel: UILabel!
    @IBOutlet var CompanySubjectLabel: UILabel!
    @IBOutlet var CompanyDescriptionTextView: UITextView!
    
    var company: Company? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CompanyNameLabel.text = company?.name;
        CompanyWebsiteLabel.text = company?.website;
        CompanySubjectLabel.text = company?.subject.name;
        CompanyDescriptionTextView.text = company?.description;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
