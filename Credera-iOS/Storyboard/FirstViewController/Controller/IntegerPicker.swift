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

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = values[row]
        if self.textField.text != nil {
            selectionHandler(self.textField.text!)
        }
        
    }
}
