//
//  SettingsViewController.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 29.11.2020.
//

import UIKit
import HealthKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func healthAuthBtnPressed(_ sender: UIButton) {
        HealthKitSetupAssistant.authorizeHealthKit {
            (authorized, error) in
            guard authorized else {
                let baseMessage = "HealthKit Authorization Failed"
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                return
            }
            
            print("HealthKit Successfully Authorized.")
            sender.isEnabled = false
        }
    }
    
    @IBAction func notificationTrigger(_ sender: UISwitch) {
    }
    
    private func displayAlert(for error: Error) {
            let alert = UIAlertController(
            title: nil, message: error.localizedDescription,
                   preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK.",
         style: .default, handler: nil))
         present(alert, animated: true, completion: nil) }

    
    func loadMostRecentHeartRate(){
        guard let heartRate = HKSampleType.quantityType(forIdentifier: .heartRate) else {
            print("Heart Rate Sample Type is no longer available in HealthKit")
            return
        }
        ProfileDataStore.getMostRecentSample(for: heartRate) {
            (sample, error) in
                guard let sample = sample else {
                    if let error = error {
                        self.displayAlert(for: error)
                    }
                    return
                }
        
                print(sample)
        }
    }

    
}
