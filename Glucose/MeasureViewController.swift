//
//  MeasureViewController.swift
//  Glucose
//
//  Created by Nicolas Trafenchuk on 28.11.2020.
//

import UIKit
import CoreData

class MeasureViewController: UIViewController {
    
    var glucoseData: Double!
    var meal = "No details"
    var date: String?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var glucoseMeasur: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        glucoseMeasur.delegate = self
    }
    
    @IBAction func mealBtnPressed(_ sender: UIButton) {
        print(sender);
        let optionMenu = UIAlertController(
            title: nil,
            message: "Select the meal dependance",
            preferredStyle: UIAlertController.Style.actionSheet
        )

        let beforeMeal = UIAlertAction(
            title: "Before meal",
            style: .default,
            handler: {
                (action) ->
                    Void in
                        self.meal = "Before meal"
                        sender.setTitle("Before meal", for: .normal)
            }
        )

        let afterMeal = UIAlertAction(
            title: "After meal",
            style: .default,
            handler: {
                (action) ->
                    Void in
                        self.meal = "After meal"
                        sender.setTitle("After meal", for: .normal)
            }
        )

        let bedtime = UIAlertAction(
            title: "Bedtime",
            style: .default,
            handler: {
                (action) ->
                    Void in
                        self.meal = "Bedtime meal"
                        sender.setTitle("Bedtime meal", for: .normal)
            }
        )

        let cancel = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: {
                (action) ->
                    Void in
                        self.meal = "No details"
                        sender.setTitle("No details", for: .normal)
            }
        )

        optionMenu.addAction(beforeMeal)
        optionMenu.addAction(afterMeal)
        optionMenu.addAction(bedtime)
        optionMenu.addAction(cancel)

        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func getGlucoseMeasure(){
        guard let measure = Double(glucoseMeasur.text!) else {
            print("Not a number: \(glucoseMeasur.text!)")
            return
        }
        self.glucoseData = measure
    }
    
    func getDate() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        
        self.date = strDate
        self.datePicker.endEditing(true)
    }
    
    func alertMessageMeasurement(){
        let alert = UIAlertController(
            title: "Oops...",
            message: "Please enter the glucose measurement",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveMeasurBtnPressed(_ sender: UIButton) {
        getGlucoseMeasure()
        getDate()
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "HistoryModel", in: context)!
        let history = NSManagedObject(entity: entity, insertInto: context)
        
        history.setValue(self.glucoseMeasur.text, forKey: "measure")
        history.setValue(self.meal, forKey: "meal")
        history.setValue(self.date, forKey: "date")
        
        do {
            try context.save()
        } catch {
            print("Could not save recipe")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension MeasureViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
}
