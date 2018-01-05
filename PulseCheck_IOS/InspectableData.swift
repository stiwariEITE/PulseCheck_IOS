//
//  InspectableData.swift
//  EITE
//
//  Created by Venkatesh Alluri on 31/10/17.
//  Copyright © 2017 Venkatesh Alluri. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set(newValue) {
            self.layer.borderWidth = newValue
            //self.layer.shadowRadius = newValue * 2
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set(newValue) {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set(newValue) {
            self.layer.borderColor = newValue?.cgColor
           // self.layer.shadowColor = (UIColor.black).cgColor
           // self.layer.shadowOffset = CGSize(width: 1, height: 1)
           // self.layer.shadowOpacity = 1.0
            
        }
    }
}

extension UIViewController {
    

    
    func setTitle(_ title: String, subtitle: String) {
        let rect = CGRect(x: 0, y: 0, width: 400, height: 50)
        let titleSize: CGFloat = 18     // adjust as needed
        let subtitleSize: CGFloat = 12
        
        let label = UILabel(frame: rect)
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string: title, attributes: [.font : UIFont.boldSystemFont(ofSize: titleSize)]))
        text.append(NSAttributedString(string: "\n\(subtitle)", attributes: [.font : UIFont.systemFont(ofSize: subtitleSize)]))
        label.attributedText = text
        self.navigationItem.titleView = label
    }
}
