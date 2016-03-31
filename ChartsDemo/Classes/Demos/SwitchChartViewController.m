//
//  SwitchChartViewController.m
//  ChartsDemo
//
//  Created by Stephen Vinouze on 30/03/16.
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

#import "SwitchChartViewController.h"
#import "ChartsDemo-Swift.h"

@interface SwitchChartViewController () <ChartViewDelegate>

@property (nonatomic, weak) IBOutlet BarChartView *barChartView;
@property (nonatomic, weak) IBOutlet LineChartView *lineChartView;

@end

@implementation SwitchChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Switch Bar Chart";
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"toggleHighlightArrow", @"label": @"Toggle Highlight Arrow"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
                     ];
    
    [_barChartView configure:self];
    [_lineChartView configure:self];
    
    [_barChartView setData:[self getBarData:_barChartView count:100 range:10]];
    [_barChartView setVisibleXRangeWithMinXRange:7 maxXRange:15];
    
    [_lineChartView setData:[self getLineData:_lineChartView count:100 range:10]];
    [_lineChartView setVisibleXRangeWithMinXRange:7 maxXRange:15];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BarChartData *)getBarData:(BarLineChartViewBase *)chart count:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i + 1) stringValue]];
        
        double val = (double) (arc4random_uniform(range));
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals3 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    return [chart generateBarChartData:xVals wearinessEntries:yVals1 painEntries:yVals2 painScoreEntries:yVals3];
}

- (LineChartData *)getLineData:(BarLineChartViewBase *) chart count:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i + 1) stringValue]];
        
        double val = (double) (arc4random_uniform(range));
        [yVals1 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    return [chart generateLineChartData:xVals wearinessEntries:yVals1 painEntries:yVals2 painScoreEntries:yVals3];
}

//private boolean switchChart(BarLineChartBase fromChart, BarLineChartBase toChart) {
//    if (!isSwitching && fromChart.getAlpha() == 1) {
//        isSwitching = true;
//        fromChart.setAlpha(0);
//        toChart.bringToFront();
//        toChart.setAlpha(1);
//        return true;
//    }
//    return false;
//}
//
//private void showBarChart() {
//    if (switchChart(mLineChart, mBarChart)) {
//        mBarChart.moveViewToX(ChartUtils.getBarUnitValue(mBarChart) * mLineChart.getLowestVisibleXIndex());
//        mBarChart.animateY(500);
//        isSwitching = false;
//    }
//}
//
//private void showLineChart() {
//    if (switchChart(mBarChart, mLineChart)) {
//        mLineChart.moveViewToX(mBarChart.getLowestVisibleXIndex());
//        mLineChart.animateX(1000);
//        isSwitching = false;
//    }
//}

- (void)optionTapped:(NSString *)key
{
    [super handleOption:key forChartView:_barChartView];
}

#pragma mark - ChartViewDelegate

- (void)chartMinScaled:(ChartViewBase *)chartView gestureAxis:(enum GestureScaleAxis)gestureAxis
{
    if (gestureAxis == GestureScaleAxisX) {
        NSLog(@"Min scale");
    }
}

- (void)chartMaxScaled:(ChartViewBase *)chartView gestureAxis:(enum GestureScaleAxis)gestureAxis
{
    if (gestureAxis == GestureScaleAxisX) {
        NSLog(@"Max scale");
    }
}

@end
