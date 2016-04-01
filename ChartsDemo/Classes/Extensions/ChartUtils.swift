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
    
    @objc
    public enum ChartMode : Int {
        case Display
        case Export
    }
    
    @objc
    public enum ChartType : Int {
        case Pain
        case Accumulation
    }
    
    func configureWithMode(mode: ChartMode, andType type: ChartType) {
        self.descriptionText = ""
        self.pinchZoomEnabled = false
        self.scaleXEnabled = true
        self.scaleYEnabled = false
        self.drawGridBackgroundEnabled = false
        self.doubleTapToZoomEnabled = false
        self.drawBordersEnabled = false
        self.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        if let barChartView = self as? BarChartView {
            barChartView.drawBarShadowEnabled = false
            barChartView.drawValueAboveBarEnabled = false
        }
        
        configureLegend(self.legend, withMode: mode)
        configureXAxis(self.xAxis, withMode: mode)
        
        switch type {
        case .Pain:
            configureYAxis(self.leftAxis, withMode: mode, andType: type, maxValue: 10)
            configureYAxis(self.rightAxis, withMode: mode, andType: type, maxValue: 21)
        case .Accumulation:
            configureYAxis(self.leftAxis, withMode: mode, andType: type, maxValue: 100)
        }
    }
    
    func configureLegend(legend: ChartLegend, withMode mode: ChartMode) {
        //legend.enabled = mode == .Export
        legend.position = .AboveChartRight
        legend.form = .Square
        legend.xEntrySpace = 10
        legend.font = configureFont()
        legend.textColor = configureTextColor(mode)
    }
    
    func configureXAxis(xAxis: ChartXAxis, withMode mode: ChartMode) {
        xAxis.labelPosition = .Bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        xAxis.labelFont = configureFont()
        xAxis.labelTextColor = configureTextColor(mode)
        
        if mode == .Export {
            xAxis.setLabelsToSkip(0)
        }
        
        if let dotXAxis = xAxis as? ChartDotXAxis {
            dotXAxis.dotSize = 15
            dotXAxis.dotOffset = 5
            dotXAxis.dotStrokeSize = 2
            dotXAxis.dotStrokeColor = self.backgroundColor!
        }
    }
    
    func configureYAxis(yAxis: ChartYAxis, withMode mode: ChartMode, andType type: ChartType, maxValue: Double) {
        let axisDependency = yAxis.axisDependency
        
        yAxis.valueFormatter = NSNumberFormatter()
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = maxValue
        yAxis.drawGridLinesEnabled = axisDependency == .Left
        yAxis.drawAxisLineEnabled = false
        yAxis.labelFont = configureFont()
        yAxis.labelTextColor = axisDependency == .Left ? configureTextColor(mode) : UIColor.redColor()
        
        if type == .Pain && axisDependency == .Left {
            yAxis.labelCount = Int(maxValue)
        }
    }
    
    func configureFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 12)!
    }
    
    func configureTextColor(chartMode: ChartMode) -> UIColor {
        switch chartMode {
        case .Display:
            return UIColor.whiteColor()
        case .Export:
            return UIColor.blackColor()
        }
    }
    
    func barUnitValue() -> Float {
        if let barChartView = self as? BarChartView {
            if let barData = barChartView.barData {
                return Float(barData.dataSetCount) + Float(barData.groupSpace)
            }
        }
        return 1;
    }
    
    func generateBarChartData(xValues: [String], dotColorSets: [[UIColor]]?, wearinessEntries: [BarChartDataEntry], painEntries: [BarChartDataEntry], painScoreEntries: [BarChartDataEntry]) -> BarChartData {
        let wearinessSet = BarChartDataSet(yVals: wearinessEntries, label: "Fatigue")
        wearinessSet.setColor(UIColor(colorLiteralRed: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        wearinessSet.axisDependency = .Left
        wearinessSet.highlightAlpha = 0
        
        let painSet = BarChartDataSet(yVals: painEntries, label: "Douleur")
        painSet.setColor(UIColor(colorLiteralRed: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        painSet.axisDependency = .Left
        painSet.highlightAlpha = 0
        
        let painScoreSet = BarChartDataSet(yVals: painScoreEntries, label: "Total score")
        painScoreSet.setColor(UIColor(colorLiteralRed: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        painScoreSet.axisDependency = .Right
        painScoreSet.highlightAlpha = 0
        
        let data = DotBarChartData(xVals: xValues, dotColorSets: dotColorSets, dataSets: [wearinessSet, painSet, painScoreSet])
        data.groupSpace = 2
        data.setDrawValues(false)
        
        return data
    }
    
    func generateLineChartData(xValues: [String], wearinessEntries: [ChartDataEntry], painEntries: [ChartDataEntry], painScoreEntries: [ChartDataEntry]) -> LineChartData {
        let wearinessSet = LineChartDataSet(yVals: wearinessEntries, label: "Fatigue")
        wearinessSet.setColor(UIColor(colorLiteralRed: 104/255, green: 241/255, blue: 175/255, alpha: 1))
        wearinessSet.axisDependency = .Left
        wearinessSet.drawCirclesEnabled = false
        wearinessSet.setDrawHighlightIndicators(false)
        
        let painSet = LineChartDataSet(yVals: painEntries, label: "Douleur")
        painSet.setColor(UIColor(colorLiteralRed: 164/255, green: 228/255, blue: 251/255, alpha: 1))
        painSet.axisDependency = .Left
        painSet.drawCirclesEnabled = false
        painSet.setDrawHighlightIndicators(false)
        
        let painScoreSet = LineChartDataSet(yVals: painScoreEntries, label: "Total score")
        painScoreSet.setColor(UIColor(colorLiteralRed: 242/255, green: 247/255, blue: 158/255, alpha: 1))
        painScoreSet.axisDependency = .Right
        painScoreSet.drawCirclesEnabled = false
        painScoreSet.setDrawHighlightIndicators(false)
        
        let data = LineChartData(xVals: xValues, dataSets: [wearinessSet, painSet, painScoreSet])
        data.setDrawValues(false)
        
        return data
    }
    
}
