//
//  ViewController.swift
//  Anfix
//
//  Created by LUCIANO WEHRLI on 12/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import UIKit
import AZDropdownMenu
import Charts


class ViewController: UIViewController, ChartViewDelegate {

    var topMenu: AZDropdownMenu?
    var metrixArray = [Metric]()
    let chartView = LineChartView()

    @IBOutlet var centralView: UIView!
    @IBOutlet var centralTitle: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var finalAmount: UILabel!
    @IBOutlet weak var finalTitle: UILabel!
    @IBOutlet weak var currency: UILabel!

    @IBOutlet weak var overlayView: UIView!
    
    var currentYear = ""{
        didSet{
            self.centralTitle.text = "\(NSLocalizedString("main_title", comment: "")) \(currentYear)"
            finalTitle.text = "\(NSLocalizedString("treasury", comment: "")) \(currentYear)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
        
        let gest = UITapGestureRecognizer(target: self, action: Selector("showLeftDropdown"))
        self.centralView.addGestureRecognizer(gest)
        self.centralTitle.text = "\(NSLocalizedString("main_title", comment: "")) \(currentYear)"

        APIRequest.getLocalJson{ (resultJson) -> Void in
            self.metrixArray.removeAll()
            for var jsonMet in resultJson{
                let metric = Metric(jsonMetric: jsonMet)
                self.metrixArray.append(metric)
            }

            //Setea labels totalizadores
            let years = self.getMainYears()
            self.currentYear = years.first!
            self.finalAmount.text = { guard let lastValue = self.filterData(metrixArray: self.metrixArray, year: self.currentYear).last?.accumulatedBalance  else{ return ""}; return String(lastValue) }()
            self.currency.text = NSLocalizedString("currency", comment: "")
            self.finalTitle.text = "\(NSLocalizedString("treasury", comment: "")) \(self.currentYear)"

            self.reloadGraph()

            let tempTopMenu = AZDropdownMenu(titles: years )
            tempTopMenu.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
                self?.currentYear = years[indexPath.row]
                self?.reloadGraph()
                self!.finalAmount.text = { guard let lastValue = self!.filterData(metrixArray: self!.metrixArray, year: self!.currentYear).last?.accumulatedBalance  else{ return ""}; return String(lastValue) }()
            }
            self.topMenu = tempTopMenu
            self.chartView.frame = CGRectMake(10, 100, self.view.frame.size.width-10, self.view.frame.size.height-230)
            self.contentView.addSubview(self.chartView)
        }

    }
    
    
    
    //MARK: NAV BAR MENU
    func showLeftDropdown(){
        if(self.topMenu?.isDescendantOfView(self.overlayView) == true) {
            self.topMenu?.hideMenu()
        } else {
            self.topMenu?.showMenuFromView(self.overlayView)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? StatisticsTableViewController{
            vc.year = currentYear
            vc.metrixArray = self.metrixArray
        }
    }
    
    
    
    //MARK: GRAPH METHODS
    func reloadGraph(){
        //recarga del gráfico en función al año seleccionado self.currentYear
        chartView.delegate = self
        chartView.descriptionText = ""
        chartView.noDataTextDescription = NSLocalizedString("graph_required_data", comment: "")
        chartView.dragEnabled = false
        chartView.setScaleEnabled(false)
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = false

        //Ejes
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.drawLabelsEnabled = false
        leftAxis.drawGridLinesEnabled = false
        leftAxis.drawAxisLineEnabled = false
        
        let ceroLine = ChartLimitLine(limit: 0.0, label: "")
        leftAxis.addLimitLine(ceroLine)
        
        let rightAxis = chartView.rightAxis
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.drawAxisLineEnabled = true
        
        chartView.leftAxis.startAtZeroEnabled = false
        chartView.rightAxis.startAtZeroEnabled = false
        
        setDataCount()
        chartView.legend.form = ChartLegend.ChartLegendForm.Line
        chartView.animate(xAxisDuration: 2.5, easingOption: ChartEasingOption.EaseInOutQuart)
    }
    
    
    func setDataCount(){
        let filteredYearDataGraph = filterData(metrixArray: self.metrixArray, year: self.currentYear)
        let xValues = [NSLocalizedString("mon1", comment: ""), NSLocalizedString("mon2", comment: ""), NSLocalizedString("mon3", comment: ""), NSLocalizedString("mon4", comment: ""), NSLocalizedString("mon5", comment: ""), NSLocalizedString("mon6", comment: ""), NSLocalizedString("mon7", comment: ""), NSLocalizedString("mon8", comment: ""), NSLocalizedString("mon9", comment: ""), NSLocalizedString("mon10", comment: ""), NSLocalizedString("mon11", comment: ""), NSLocalizedString("mon12", comment: "")]
        
        var yValues = [ChartDataEntry]()

        var set : LineChartDataSet?
        var dataSet = [LineChartDataSet]()
        loadYValues(&yValues, from: 1, to: 12, filteredArray: filteredYearDataGraph)
        set = configSet(yValues: yValues)
        dataSet.append(set!)
        
        let data = LineChartData(xVals: xValues, dataSets: dataSet)
        chartView.data = data
    }
    
    
    
    func filterData(metrixArray metrixArray: Array<Metric>, year:String) -> Array<Metric>{
        return metrixArray.filter{
            $0.year! == Int(year)
        }
    }

    
    
    func loadYValues(inout yValues: Array<ChartDataEntry>, from: Int, to: Int, filteredArray: Array<Metric>){
        yValues.removeAll()
        var segment : ChartDataEntry!
        for var i in from...to{
            let metricValue = filteredArray.filter{ $0.month! == i }
            if metricValue.isEmpty{
                segment = ChartDataEntry(value: 0.0, xIndex: i)
            }else{
                print(metricValue[0].accumulatedBalance)
                segment = ChartDataEntry(value: Double(metricValue[0].accumulatedBalance!), xIndex: i)
            }
            yValues.append(segment)
        }
    }
    
    
    func configSet(yValues yValues: Array<ChartDataEntry>) -> LineChartDataSet{
        let set1 = LineChartDataSet(yVals: yValues, label: "")
        set1.lineDashLengths = [5.0, 2.5]
        let color = UIColor().RBGColor(red: 10, green: 103, blue: 183)
        set1.setColor(color)
        
        set1.setCircleColor(color)
        set1.lineWidth = 2.0
        set1.drawCircleHoleEnabled = true
        set1.valueFont = UIFont(name: "HelveticaNeue-Light", size: 9.0)!
        set1.fillAlpha = 65/255.0
        set1.fillColor = UIColor.lightGrayColor()
        set1.drawCubicEnabled = true
        return set1
    }
    
    
    func getMaxMinAccumulatedBalance(order: String) -> Double{
        let val = metrixArray.sort { (metric1, metric2) -> Bool in
            if order == "Max"{
                return metric1.accumulatedBalance > metric2.accumulatedBalance
            }else{
                return metric1.accumulatedBalance < metric2.accumulatedBalance
            }
        }
        
        if let maxAc = val.first?.accumulatedBalance{
            return Double(round(100*maxAc)/100)
        }
        else { return 0.0 }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: Utils
    func getMainYears() -> Array<String>{
        let tempArray = self.metrixArray.map{ String($0.year!) }
        var dictTemp = [String:Int]()
        for var item in tempArray{
            dictTemp[item] = 0
        }
        return Array(dictTemp.keys)
    }

    func setStyles(){
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.barTintColor = UIColor().RBGColor(red: 10, green: 103, blue: 183)
        self.navigationController?.navigationBar.translucent = false
    }
}


