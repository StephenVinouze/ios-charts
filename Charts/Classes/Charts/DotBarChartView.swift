//
//  DotBarChartView.swift
//  ChartsDemo
//
//  Created by VINOUZE Stephen on 01/04/2016.
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation

public class DotBarChartView: BarChartView {
    
    internal override func initialize()
    {
        super.initialize()
        
        _xAxis = ChartDotXAxis()
        _xAxisRenderer = ChartXAxisRendererDotBarChart(viewPortHandler: _viewPortHandler, xAxis: _xAxis, transformer: _leftAxisTransformer, chart: self)
    }
    
}
