//
//  ViewController.swift
//  viewPickerDate
//
//  Created by Berke Ersiz on 6.01.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateField: UITextField!
    
    let month = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var pickerYears: [String] = []
    var pickerViewDate = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nowYear = Date()
        let calendar = Calendar.current
        let currentYear = Calendar.current.component(.year, from: Date())
        let years = (currentYear...currentYear+40).map { String($0) }
        pickerYears = years
        
        self.pickerViewDate.delegate = self
        self.pickerViewDate.dataSource = self
        dateField.placeholder = "Ay/Yıl"
        dateField.inputView = self.pickerViewDate
        dateField.textAlignment = .center
        pickUp(dateField)
    }


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return month.count
        }
        return pickerYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return month[row]
        }
        return pickerYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Todo
        
    }
    
    func pickUp(_ textField : UITextField){
        
        // UIPickerView
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        textField.inputView = pickerView
//        textField.textAlignment = .center
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClick() {
        let selectedYear = pickerYears[pickerViewDate.selectedRow(inComponent: 0)]
        let selectedMonth = month[pickerViewDate.selectedRow(inComponent: 1)]
        dateField.text = "\(selectedMonth) / \(selectedYear)"
        dateField.resignFirstResponder()
    }
    
    @objc func cancelClick() {

        view.endEditing(true)
    }
    
    
    
}

