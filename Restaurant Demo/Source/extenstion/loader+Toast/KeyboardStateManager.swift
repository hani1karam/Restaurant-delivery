//
//  KeyboardStateManager.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/13/21.
//

import Foundation
import Cosmos

class KeyboardStateManager {
    
    static let shared = KeyboardStateManager()
    
    var isVisible = false
    var keyboardOffset: CGFloat = 0
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleShow(_ notification: Notification) {
        isVisible = true
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardOffset = keyboardRectangle.height
        }
    }
    
    @objc func handleHide()
    {
        isVisible = false
    }
    
    func stop() {
        NotificationCenter.default.removeObserver(self)
    }
}
