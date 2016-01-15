//
//  APIRequest.swift
//  Anfix
//
//  Created by Luciano Wehrli on 13/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import Foundation

class APIRequest{
    static func getLocalJson(completion:(resultJson: Array<Dictionary<String,AnyObject>>) -> Void ){
        if let path = NSBundle.mainBundle().pathForResource("2016-treasury", ofType: "json")
        {
            do{
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                    if let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    {
                        if let outputData : Dictionary<String,AnyObject> = jsonResult["outputData"] as? Dictionary<String,AnyObject>
                        {
                            if let treasuryDataGraph = outputData["TreasuryDataGraph"] as? Dictionary<String,AnyObject>{
                                if let treasuryGraphData = treasuryDataGraph["TreasuryGraphData"] as? Dictionary<String,AnyObject>{
                                    if let graphDataArray = treasuryGraphData["TreasuryGraph"] as? Array<Dictionary<String,AnyObject>>{
                                        completion(resultJson: graphDataArray)
                                    }
                                }
                            }
                        }
                    }
            }catch _ {
                
            }
        }
    }    
}