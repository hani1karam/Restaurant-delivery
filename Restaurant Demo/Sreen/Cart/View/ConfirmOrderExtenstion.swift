//
//  ConfirmOrderExtenstion.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/17/21.
//

import UIKit
extension ConfirmOrderVC: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == self.view {
            return true
        } else {
            return false
        }
    }
}
