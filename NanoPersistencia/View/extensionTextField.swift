//
//  CurrencyTextField.swift
//  DesafioIosMobils
//
//  Created by Lidiane Gomes Barbosa on 09/10/20.
//

import UIKit
extension UITextField {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
}

