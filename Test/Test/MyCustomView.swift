//
//  MyCustomView.swift
//  Test
//
//  Created by Bunty on 02/03/17.
//  Copyright © 2017 Bunty. All rights reserved.
//

import UIKit

@IBDesignable
class MyCustomView: UIButton {
    
    @IBInspectable var textColor: UIColor = UIColor.black
    
    @IBInspectable
    public var cornerRadious : CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerRadious
        }
    }
    
    @IBInspectable
    public var borderColor : UIColor? {
        didSet{
            self.layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable
    public var borderWidth : CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
}
