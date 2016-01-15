//
//  StatisticsTableViewController.swift
//  Anfix
//
//  Created by LUCIANO WEHRLI on 12/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import UIKit

class StatisticsTableViewController: UITableViewController {

    
    var year : String?
    var metrixArray = [Metric]()
    
    var dataDict = [String : Array<Metric>]()
    var keys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()

        if let yearText = year{ self.title =  "\(NSLocalizedString("data_list", comment: ""))" }
        
        let years = metrixArray.map{ $0.year! }
        for var ye in years{
            let metricItem = metrixArray.filter{ $0.year! == ye }
            dataDict[String(ye)] = metricItem
        }
        keys = Array(dataDict.keys)
    }

    
    
    // MARK: - TABLEVIEW

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let index = keys[section]
        return (dataDict[index]?.count)!
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width, 25))
        v.backgroundColor = UIColor().RBGColor(red: 200, green: 220, blue: 240)
        let title = UILabel(frame: CGRectMake(v.frame.origin.x + 5, v.frame.origin.y, v.frame.size.width, v.frame.size.height))
        title.text = keys[section]
        title.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        title.tintColor = UIColor().RBGColor(red: 240, green: 240, blue: 240)
        v.addSubview(title)
        return v
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : StatisticsTableViewCell = tableView.dequeueReusableCellWithIdentifier("statisticCellIdentifier", forIndexPath: indexPath) as! StatisticsTableViewCell
        let index = keys[indexPath.section]
        let currentMetrix = dataDict[index]![indexPath.row]
        
        cell.accumulatedBalance.text = "\(currentMetrix.accumulatedBalance!)"
        cell.monthName.text = Tools.getLiteralMonth(currentMetrix.month!)
        cell.completeDate.text = "01/\(currentMetrix.month!)/\(year!)"
        cell.currency.text = NSLocalizedString("currency", comment: "")
        
        return cell
    }
    
    
    
    //MARK: STYLES
    func setStyles(){
        self.view.backgroundColor = UIColor().RBGColor(red: 200, green: 220, blue: 240)
        navigationController?.navigationBar.barTintColor = UIColor().RBGColor(red: 10, green: 103, blue: 183)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
