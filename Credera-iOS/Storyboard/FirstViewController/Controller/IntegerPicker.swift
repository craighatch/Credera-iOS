//
//  IntegerPicker.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 5/13/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
class IntegerPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    let values = ["1", "2", "3", "4"]
    var textField: UITextField
    var selectionHandler : ((_ selectedText: String) -> Void)
    init( textField: UITextField!, frame: CGRect, selectionHandler : @escaping ((_ selectedText: String) -> Void)) {
        self.textField = textField
        self.selectionHandler = selectionHandler
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Sets number of columns in picker view
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }

    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }

    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }

    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = values[row]
        print("asdf: \(textField.text)")
        if (self.textField.text != nil) {
            selectionHandler(self.textField.text!)
        }
    }
}
