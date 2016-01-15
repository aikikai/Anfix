//
//  colorExtension.swift
//  Anfix
//
//  Created by Luciano Wehrli on 13/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{

    func RBGColor (red red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }

    func RBGColor (red red:CGFloat, green:CGFloat, blue:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }    
}