//
//  UIColorExtension.swift
//  surechigaiApp
//
//  Created by 川村周也 on 2019/02/16.
//  Copyright © 2019 川村周也. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    class func BlueStringColor() -> UIColor {
        return UIColor.rgb(r: 77, g: 163, b: 226, alpha: 1.0)
    }
    
    class func LightBlueColor() -> UIColor {
        return UIColor.rgb(r: 155, g: 225, b: 240, alpha: 1.0)
    }
    
}
