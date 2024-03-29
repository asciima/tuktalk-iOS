//
//  UITextFieldExtension.swift
//  TukTalk-iOS
//
//  Created by 한상진 on 2021/10/17.
//

import UIKit

extension UITextField {
    func setUnderline(_ active: Bool) {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 0
        layer.shadowColor = active ? UIColor.Primary.primary.cgColor : UIColor.systemGray4.cgColor
    }
}
