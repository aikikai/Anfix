//
//  tools.swift
//  Anfix
//
//  Created by Luciano Wehrli on 13/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import Foundation

class Tools{

    static func getLiteralMonth(month: Int) -> String{
        switch month{
        case 1: return NSLocalizedString("month_1", comment: "")
        case 2: return NSLocalizedString("month_2", comment: "")
        case 3: return NSLocalizedString("month_3", comment: "")
        case 4: return NSLocalizedString("month_4", comment: "")
        case 5: return NSLocalizedString("month_5", comment: "")
        case 6: return NSLocalizedString("month_6", comment: "")
        case 7: return NSLocalizedString("month_7", comment: "")
        case 8: return NSLocalizedString("month_8", comment: "")
        case 9: return NSLocalizedString("month_9", comment: "")
        case 10: return NSLocalizedString("month_10", comment: "")
        case 11: return NSLocalizedString("month_11", comment: "")
        default: return NSLocalizedString("month_12", comment: "")
        }
    }

}