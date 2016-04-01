//
//  DotBarChartData.swift
//  ChartsDemo
//
//  Created by VINOUZE Stephen on 01/04/2016.
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation

public class DotBarChartData: BarChartData {
    
    public var dotColorSets: [[Int]]
    
    public init(xVals: [NSObject]?, dotColorSets: [[Int]], dataSets: [IChartDataSet]?)
    {
        self.dotColorSets = dotColorSets
        
        super.init(xVals: xVals, dataSets: dataSets)
    }
    
}
