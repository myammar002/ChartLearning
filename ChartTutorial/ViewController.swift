//
//  ViewController.swift
//  ChartTutorial
//
//  Created by Ammar on 20/05/22.
//

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    @IBOutlet weak var lineChartView: UIView!
    
//    var xValues : [String] = ["12", "15" ,"17"]
//    var yValues : [Double] = [60, 50, 30]
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 9.0),
        ChartDataEntry(x: 3.0, y: 20.0),
        ChartDataEntry(x: 4.0, y: 11.0),
        ChartDataEntry(x: 5.0, y: 3.0)
    ]
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    // Buat Customization Chart
    lazy var ChartView: LineChartView = {
        let chartView = LineChartView()
        //chartView.backgroundColor = .systemGray6
        chartView.rightAxis.enabled = true
        chartView.leftAxis.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        
//        chartView.rightAxis.axisMaximum = 60.0
//        chartView.rightAxis.axisMinimum = 20.0
        
        let yAxis = chartView.rightAxis
        yAxis.labelPosition = .outsideChart
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.labelTextColor = UIColor(named: "month")  ?? .gray
        yAxis.axisLineColor = UIColor(named: "month") ?? .gray
       
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.labelTextColor = UIColor(named: "month")  ?? .gray
        chartView.xAxis.axisLineColor = .blue
        
        chartView.xAxis.drawGridLinesEnabled = false
        
        //axisMaximum dan Minimum untuk mengatur
//        chartView.xAxis.axisMaximum = Double(xValues.count) - 0.5
        chartView.xAxis.axisMinimum = -0.5
        chartView.extraBottomOffset = 10
        
        // Granularity itu seperti range bilangan
//        chartView.xAxis.granularity = 1
//        chartView.rightAxis.granularity = 5
        chartView.animate(xAxisDuration: 1.5)
        return chartView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // set chart delegate
        ChartView.delegate = self
        
        // Chart size
        ChartView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: screenWidth * 0.86,
                                     height: screenHeight * 0.2)
        lineChartView.addSubview(ChartView)
        
        // Constrains for Chart
        ChartView.translatesAutoresizingMaskIntoConstraints = false
        ChartView.leadingAnchor.constraint(equalTo: lineChartView.leadingAnchor, constant:0).isActive = true
        ChartView.topAnchor.constraint(equalTo: lineChartView.topAnchor, constant: 0).isActive = true
        ChartView.bottomAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: 0).isActive = true
        ChartView.trailingAnchor.constraint(equalTo: lineChartView.trailingAnchor, constant: 0).isActive = true
        
        // Data Charts
        setData()
        ChartView.setVisibleXRange(minXRange: 5, maxXRange: 5)
    }

    func setData() {
        let set1 = LineChartDataSet(entries:yValues , label: "Subcribers")
        set1.drawCirclesEnabled = true

        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        ChartView.data = data

//        ChartView.setLineChartData(xValues: xValues, yValues: yValues, label: "Subscribers")
    }
    
}

//extension LineChartView {
//
//    private class LineChartFormatter: NSObject, IAxisValueFormatter {
//
//        var labels: [String] = []
//
//
//        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//            let intValue = Int(value)
//            if intValue < 0 || intValue >= labels.count {
//                return ""
//            } else {
//                return labels[intValue]
//            }
//        }
//
//        init(labels: [String]) {
//            super.init()
//            self.labels = labels
//        }
//    }
//
//    func setLineChartData(xValues: [String], yValues: [Double], label: String) {
//
//        var dataEntries: [ChartDataEntry] = []
//
//        for i in 0..<yValues.count {
//            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
//            dataEntries.append(dataEntry)
//        }
//
//
//        let chartDataSet = LineChartDataSet(entries: dataEntries, label: label)
//        chartDataSet.drawCircleHoleEnabled = false
//        chartDataSet.circleHoleColor = UIColor(named: "Turqoise")
//        chartDataSet.setColor(.blue)
//        chartDataSet.drawHorizontalHighlightIndicatorEnabled = false
//        chartDataSet.axisDependency = YAxis.AxisDependency.right
//        let chartData = LineChartData(dataSet: chartDataSet)
//        chartData.setDrawValues(false)
//        let chartFormatter = LineChartFormatter(labels: xValues)
//        self.xAxis.valueFormatter = chartFormatter
//        self.data = chartData
//
//    }
//}
