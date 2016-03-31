//
//  File.swift
//  ChartsDemo
//
//  Created by VINOUZE Stephen on 31/03/2016.
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation
import Charts

public extension BarLineChartViewBase {
    
    func configureWithDelegate(delegate: ChartViewDelegate?) {
        self.delegate = delegate
        self.descriptionText = ""
        self.pinchZoomEnabled = false
        self.scaleYEnabled = false
        self.drawGridBackgroundEnabled = false
        self.doubleTapToZoomEnabled = false
        
        if let barChartView = self as? BarChartView {
            barChartView.drawBarShadowEnabled = false
        }
        
        configureLegend(self.legend)
        configureXAxis(self.xAxis)
        configureYAxis(self.leftAxis)
        configureYAxis(self.rightAxis)
    }
    
    func configureLegend(legend: ChartLegend) {
        legend.position = .AboveChartRight
        legend.font = configureFont()
    }
    
    func configureXAxis(xAxis: ChartXAxis) {
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.labelFont = configureFont()
    }
    
    func configureYAxis(yAxis: ChartYAxis) {
        yAxis.valueFormatter = NSNumberFormatter()
        yAxis.valueFormatter?.maximumFractionDigits = 1
        yAxis.drawGridLinesEnabled = true
        yAxis.labelFont = configureFont()
    }
    
    func configureFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 12)!
    }
    
    func barUnitValue() -> Float {
        if let barChartView = self as? BarChartView {
            if let barData = barChartView.barData {
                return Float(barData.dataSetCount) + Float(barData.groupSpace)
            }
        }
        return 1;
    }
    
    func generateBarChartData(xValues: [String], wearinessEntries: [BarChartDataEntry], painEntries: [BarChartDataEntry], painScoreEntries: [BarChartDataEntry]) -> BarChartData {
        let wearinessSet = BarChartDataSet(yVals: wearinessEntries, label: "Fatigue")
        wearinessSet.setColor(UIColor(colorLiteralRed: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        let painSet = BarChartDataSet(yVals: painEntries, label: "Douleur")
        painSet.setColor(UIColor(colorLiteralRed: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        let painScoreSet = BarChartDataSet(yVals: painScoreEntries, label: "Total score")
        painScoreSet.setColor(UIColor(colorLiteralRed: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        let data = BarChartData(xVals: xValues, dataSets: [wearinessSet, painSet, painScoreSet])
        data.groupSpace = 2
        data.setValueFont(configureFont())
        
        return data
    }
    
    func generateLineChartData(xValues: [String], wearinessEntries: [ChartDataEntry], painEntries: [ChartDataEntry], painScoreEntries: [ChartDataEntry]) -> LineChartData {
        let wearinessSet = LineChartDataSet(yVals: wearinessEntries, label: "Fatigue")
        wearinessSet.setColor(UIColor(colorLiteralRed: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        
        let painSet = LineChartDataSet(yVals: painEntries, label: "Douleur")
        painSet.setColor(UIColor(colorLiteralRed: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        
        let painScoreSet = LineChartDataSet(yVals: painScoreEntries, label: "Total score")
        painScoreSet.setColor(UIColor(colorLiteralRed: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        
        let data = LineChartData(xVals: xValues, dataSets: [wearinessSet, painSet, painScoreSet])
        data.setValueFont(configureFont())
        
        return data
    }
    
}
