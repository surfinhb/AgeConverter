//
//  ViewController.swift
//  Years
//
//  Created by Jake Shapiro on 4/10/20.
//  Copyright © 2020 Jake Shapiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: outlets and variables
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var animalTextField: UITextField!
    @IBOutlet weak var animalAgeLabel: UILabel!
    @IBOutlet weak var textViewHC: NSLayoutConstraint!
    @IBOutlet weak var wouldBe: UILabel!
    @IBOutlet weak var asA: UILabel!
    
    
    // housefly 4 weeks, Mayfly 24 hours, housefly 24 hours, human 79 years, jelly immortal
    let humanLifespan = 80.0
    var animals = ["Dog": 13 , "Cat": 16, "Guinea Pig": 4, "Sea Turtle": 152, "House fly": 0.07, "Mayfly": 0.003, "Parrot": 95, "Horse": 30, "Chameleon": 1,  "Bristelcone Pine Tree": 5000, "Turritopsis nutricula jellyfish": 0]
    var animalNames = [String]()
    
    // MARK: View did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        //creating a list of animal names for use in Picker
        animalNames = Array(animals.keys)
        createAnimalPicker()
        print(convertAge(animalName: "Dog", humanAge: "24"))
        print("tc ")
        print(timeConvert(years: convertAge(animalName: "Dog", humanAge: "1")))
    }
    
    // converts age of human into target animals age
    func convertAge(animalName: String, humanAge: String) -> Double{
        
        let animalLifespan = animals[animalName]
        if let al = animalLifespan, let ha = Double(humanAge) {
            return (al * ha) / humanLifespan
        }
        return 0.0
    }
    
    // converts years into months and days
    func timeConvert(years: Double) -> String {
        var y = "", m = "", d = "", h = ""
        let months = abs(years.remainder(dividingBy: 1)) * 12
        let days = abs(months.remainder(dividingBy: 1)) * 30
        let hours = abs(days.remainder(dividingBy: 1)) * 24
        
        // formatting
        if years >= 1 {
            y = "\(Int(years)) years"
        }
        if years < 5 {
            if months >= 1 {
                m = " \(Int(months)) months"
            }
            if months < 5 && years < 1 {
                if days >= 1 {
                    d = " \(Int(days)) days"
                }
                if days < 10 && months < 1 {
                    h = " \(Int(hours)) hours"
                }
            }
        }
        
        
        return "\(y)\(m)\(d)\(h) old"
    }
    
    func createAnimalPicker(){
        let animalPicker = UIPickerView()
        animalPicker.delegate = self
        animalTextField.inputView = animalPicker
    }
}

// MARK: extending for picker view functinoality
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // number of collumns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animalNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        animalTextField.text = animalNames[row]
        if let yourAge = ageLabel.text {
            animalAgeLabel.isHidden = false
            asA.isHidden = false
            wouldBe.isHidden = false
            if animalNames[row] == "Turritopsis nutricula jellyfish" {
                animalAgeLabel.text = "immortal"
            } else {
                let animalAgeInYears = convertAge(animalName: animalNames[row], humanAge: yourAge)
                animalAgeLabel.text = timeConvert(years: animalAgeInYears)
            }
        }
        self.view.endEditing(true)
    }
}

