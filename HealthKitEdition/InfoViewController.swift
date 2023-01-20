//
//  InfoViewController.swift
//  HealthKitEdition
//
//  Created by Airi Furukawa on 2022/11/11.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AboutFood(_ sender: Any) {
        UserDefaults.standard.set("mensturation+food", forKey: "WantedInformation")
    }
    @IBAction func AboutExercise(_ sender: Any) {
        UserDefaults.standard.set("mensturation+exercise", forKey: "WantedInformation")
    }
    @IBAction func AboutMerch(_ sender: Any) {
        UserDefaults.standard.set("mensturation+merchandise", forKey: "WantedInformation")
    }
    
    
}
