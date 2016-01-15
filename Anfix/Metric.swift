//
//  metric.swift
//  Anfix
//
//  Created by Luciano Wehrli on 13/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import Foundation

class Metric{
    var year : Int?
    var month : Int?
    var columnIndex : Int?
    var accumulatedBalance : Float?
    
    init(jsonMetric: Dictionary<String,AnyObject>){
        year = jsonMetric["Year"] as? Int
        month = jsonMetric["Month"] as? Int
        columnIndex = jsonMetric["ColumnIndex"] as? Int
        accumulatedBalance = jsonMetric["AccumulatedBalance"] as? Float
    }
}