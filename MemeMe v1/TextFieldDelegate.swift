//
//  TopTextFieldDelegate.swift
//  MemeMe v1
//
//  Created by Dilip Agheda on 29/12/21.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
