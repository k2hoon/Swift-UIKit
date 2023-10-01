//
//  SearchBar+TextField.swift
//  Swift-UIKit
//
//  Created by k2hoon on 2023/10/02.
//

import UIKit

extension SearchBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        self.dismissKeyboard()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
        self.isKeyboardActive = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        self.isKeyboardActive = false
    }
}
