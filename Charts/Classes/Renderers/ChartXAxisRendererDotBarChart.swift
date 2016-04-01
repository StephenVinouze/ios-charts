//
//  ChartXAxisRendererDotBarChart.swift
//  ChartsDemo
//
//  Created by VINOUZE Stephen on 01/04/2016.
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation

public class ChartXAxisRendererDotBarChart: ChartXAxisRendererBarChart {
    
//    public override func drawLabels(context context: CGContext, pos: CGFloat, anchor: CGPoint) {
//        guard let
//            xAxis = xAxis,
//            barData = chart?.data as? BarChartData
//            else { return }
//        
//        if (!xAxis.isDrawGridLinesEnabled || !xAxis.isEnabled)
//        {
//            return
//        }
//        
//        let step = barData.dataSetCount
//        
//        CGContextSaveGState(context)
//        
//        CGContextSetShouldAntialias(context, xAxis.gridAntialiasEnabled)
//        CGContextSetStrokeColorWithColor(context, xAxis.gridColor.CGColor)
//        CGContextSetLineWidth(context, xAxis.gridLineWidth)
//        CGContextSetLineCap(context, xAxis.gridLineCap)
//        
//        if (xAxis.gridLineDashLengths != nil)
//        {
//            CGContextSetLineDash(context, xAxis.gridLineDashPhase, xAxis.gridLineDashLengths, xAxis.gridLineDashLengths.count)
//        }
//        else
//        {
//            CGContextSetLineDash(context, 0.0, nil, 0)
//        }
//        
//        let valueToPixelMatrix = transformer.valueToPixelMatrix
//        
//        var position = CGPoint(x: 0.0, y: 0.0)
//        
//        for i in self.minX.stride(to: self.maxX, by: xAxis.axisLabelModulus)
//        {
//            position.x = CGFloat(i * step) + CGFloat(i) * barData.groupSpace - 0.5
//            position.y = 0.0
//            position = CGPointApplyAffineTransform(position, valueToPixelMatrix)
//            
//            if (viewPortHandler.isInBoundsX(position.x))
//            {
//                _gridLineSegmentsBuffer[0].x = position.x
//                _gridLineSegmentsBuffer[0].y = viewPortHandler.contentTop
//                _gridLineSegmentsBuffer[1].x = position.x
//                _gridLineSegmentsBuffer[1].y = viewPortHandler.contentBottom
//                CGContextStrokeLineSegments(context, _gridLineSegmentsBuffer, 2)
//            }
//        }
//        
////        CGContextSetFillColorWithColor(context, formColor.CGColor)
////        CGContextFillEllipseInRect(context, CGRect(x: x, y: y - formsize / 2.0, width: formsize, height: formsize))
//        
//        CGContextRestoreGState(context)
//    }
    
}