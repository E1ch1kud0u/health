//
//  AccessViewController.swift
//  HealthKitEdition
//
//  Created by Airi Furukawa on 2022/11/04.
//


import HealthKit
import UIKit

class AccessViewController: UIViewController {
    
    var isHealthAvailable : Bool!
    var healthStore: HKHealthStore!
    
    @IBOutlet weak var enabledHealthKitLabel: UILabel!
    @IBOutlet weak var healthStoreLabel: UILabel!
    @IBOutlet weak var requestResultLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkHealthKit()
    }

    @IBAction func onAccessRequest(_ sender: Any) {
        let allTypes = Set([
            HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!,
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
        ])

        self.healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
            var result = ""
            if success {
                result = "アクセス許可: \(String(describing: success))"
            } else {
                result = "\(String(describing: error?.localizedDescription))"
            }
            DispatchQueue.main.async {
                self.requestResultLabel.text = result
            }
        }
        UserDefaults.standard.set(isHealthAvailable, forKey: "access")
        UserDefaults.standard.set(healthStore, forKey: "store")
    }
 
    func checkHealthKit() {
        self.isHealthAvailable = HKHealthStore.isHealthDataAvailable()
        self.enabledHealthKitLabel.text = "Healthデータ利用 : \(self.isHealthAvailable!)"
        
        if self.isHealthAvailable {
            healthStore = HKHealthStore()
        }
        healthStoreLabel.text = "HealthStore : \(String(describing: self.healthStore))"
    }
}
