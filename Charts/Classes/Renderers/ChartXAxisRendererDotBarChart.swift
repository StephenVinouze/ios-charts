//
//  ChartXAxisRendererDotBarChart.swift
//  ChartsDemo
//
//  Created by VINOUZE Stephen on 01/04/2016.
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation

public class ChartXAxisRendererDotBarChart: ChartXAxisRendererBarChart {
    
    public override init(viewPortHandler: ChartViewPortHandler, xAxis: ChartXAxis, transformer: ChartTransformer!, chart: BarChartView)
    {
        super.init(viewPortHandler: viewPortHandler, xAxis: xAxis, transformer: transformer, chart: chart)
    }
    
    public override func computeAxis(xValAverageLength xValAverageLength: Double, xValues: [String?])
    {
        guard let xAxis = xAxis as? ChartDotXAxis else { return }
        
        var a = ""
        
        let max = Int(round(xValAverageLength + Double(xAxis.spaceBetweenLabels)))
        
        for _ in 0 ..< max
        {
            a += "h"
        }
        
        let widthText = a as NSString
        
        let labelSize = widthText.sizeWithAttributes([NSFontAttributeName: xAxis.labelFont])
        let labelRotatedSize = ChartUtils.sizeOfRotatedRectangle(labelSize, degrees: xAxis.labelRotationAngle)
        let dotsHeight = xAxis.dotSize + xAxis.dotOffset * 2
        
        xAxis.labelWidth = labelSize.width
        xAxis.labelHeight = labelSize.height + dotsHeight
        xAxis.labelRotatedWidth = labelRotatedSize.width
        xAxis.labelRotatedHeight = labelRotatedSize.height + dotsHeight
        
        xAxis.values = xValues
    }
    
    public override func drawLabels(context context: CGContext, pos: CGFloat, anchor: CGPoint)
    {
        guard let
            xAxis = xAxis as? ChartDotXAxis,
            barData = chart?.data as? DotBarChartData
            else { return }
        
        let paraStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .Center
        
        let labelAttrs = [NSFontAttributeName: xAxis.labelFont,
                          NSForegroundColorAttributeName: xAxis.labelTextColor,
                          NSParagraphStyleAttributeName: paraStyle]
        let labelRotationAngleRadians = xAxis.labelRotationAngle * ChartUtils.Math.FDEG2RAD
        
        let step = barData.dataSetCount
        
        let valueToPixelMatrix = transformer.valueToPixelMatrix
        
        var position = CGPoint(x: 0.0, y: 0.0)
        
        var labelMaxSize = CGSize()
        
        if (xAxis.isWordWrapEnabled)
        {
            labelMaxSize.width = xAxis.wordWrapWidthPercent * valueToPixelMatrix.a
        }
        
        for i in self.minX...self.maxX
        {
            let label = i >= 0 && i < xAxis.values.count ? xAxis.values[i] : nil
            if (label == nil)
            {
                continue
            }
            
            position.x = CGFloat(i * step) + CGFloat(i) * barData.groupSpace + barData.groupSpace / 2.0
            position.y = 0.0
            
            // consider groups (center label for each group)
            if (step > 1)
            {
                position.x += (CGFloat(step) - 1.0) / 2.0
            }
            
            position = CGPointApplyAffineTransform(position, valueToPixelMatrix)
            
            if (viewPortHandler.isInBoundsX(position.x))
            {
                if (xAxis.isAvoidFirstLastClippingEnabled)
                {
                    // avoid clipping of the last
                    if (i == xAxis.values.count - 1)
                    {
                        let width = label!.sizeWithAttributes(labelAttrs).width
                        
                        if (position.x + width / 2.0 > viewPortHandler.contentRight)
                        {
                            position.x = viewPortHandler.contentRight - (width / 2.0)
                        }
                    }
                    else if (i == 0)
                    { // avoid clipping of the first
                        let width = label!.sizeWithAttributes(labelAttrs).width
                        
                        if (position.x - width / 2.0 < viewPortHandler.contentLeft)
                        {
                            position.x = viewPortHandler.contentLeft + (width / 2.0)
                        }
                    }
                }
                
                if i % xAxis.axisLabelModulus == 0 {
                    drawLabel(context: context, label: label!, xIndex: i, x: position.x, y: pos, attributes: labelAttrs, constrainedToSize: labelMaxSize, anchor: anchor, angleRadians: labelRotationAngleRadians)
                }
                
                let colors = barData.dotColorSets?[i]
                if let dotColors = colors {
                    let colorCount = CGFloat(dotColors.count)
                    for color in colors! {
                        let dotIndex = dotColors.indexOf(color)!
                        let dotSize = xAxis.dotSize
                        let dotSpace = dotSize / 2
                        let width = dotSize * CGFloat(colorCount) - dotSpace * (colorCount - 1)
                        let startDotX = position.x + (dotSize - width) / 2 - dotSize / 2
                        let dotX = startDotX + (dotSize - dotSpace) * CGFloat(dotIndex)
                        let dotY = pos + dotSize + xAxis.dotOffset
                        drawDot(context, x: dotX, y: dotY, size: dotSize, color: color, strokeSize: xAxis.dotStrokeSize, strokeColor: xAxis.dotStrokeColor)
                    }
                }
            }
        }
    }
    
    func drawDot(context: CGContext, x: CGFloat, y: CGFloat, size: CGFloat, color: UIColor, strokeSize: CGFloat, strokeColor: UIColor) {
        let rect = CGRect(x: x, y: y, width: size, height: size)
        
        CGContextSaveGState(context)
        
        CGContextSetLineWidth(context, strokeSize);
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
        CGContextStrokeEllipseInRect(context, rect)
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillEllipseInRect(context, rect)
        
        CGContextRestoreGState(context)
    }
    
}