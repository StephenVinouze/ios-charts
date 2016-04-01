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
{
    BOOL _isSwitching;
}

@property (nonatomic, weak) IBOutlet DotBarChartView *barChartView;
@property (nonatomic, weak) IBOutlet LineChartView *lineChartView;

@end

@implementation SwitchChartViewController

static int kMinimumVisibleEntries = 7;
static int kMaximumVisibleEntries = 15;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    
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
    
    int max = 100;
    int range = 10;
    
    NSMutableArray *xVals = [NSMutableArray new];
    NSMutableArray *colorSets = [NSMutableArray new];
    NSMutableArray *yVals1 = [NSMutableArray new];
    NSMutableArray *yVals2 = [NSMutableArray new];
    NSMutableArray *yVals3 = [NSMutableArray new];
    NSMutableArray *yBarVals1 = [NSMutableArray new];
    NSMutableArray *yBarVals2 = [NSMutableArray new];
    NSMutableArray *yBarVals3 = [NSMutableArray new];
    
    for (int i = 0; i < max; i++)
    {
        NSMutableArray *colors = [NSMutableArray new];
        [colors addObject:[UIColor redColor]];
        [colors addObject:[UIColor greenColor]];
        [colors addObject:[UIColor yellowColor]];
        
        [xVals addObject:[@(i + 1) stringValue]];
        [colorSets addObject:colors];
        
        double val = (double) (arc4random_uniform(range));
        [yVals1 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
        [yBarVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals2 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
        [yBarVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(range));
        [yVals3 addObject:[[ChartDataEntry alloc] initWithValue:val xIndex:i]];
        [yBarVals3 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    [_barChartView configureWithMode:ChartModeDisplay andType:ChartTypePain];
    [_barChartView setDelegate:self];
    [_barChartView setData:[_barChartView generateBarChartData:xVals dotColorSets:colorSets wearinessEntries:yBarVals1 painEntries:yBarVals2 painScoreEntries:yBarVals3]];
    [_barChartView setVisibleXRangeWithMinXRange:([_barChartView barUnitValue] * kMinimumVisibleEntries) maxXRange:([_barChartView barUnitValue] * kMaximumVisibleEntries)];
    [_barChartView zoom:(max / kMinimumVisibleEntries) scaleY:1 x:0 y:0];
    
    [_lineChartView configureWithMode:ChartModeDisplay andType:ChartTypePain];
    [_lineChartView setDelegate:self];
    [_lineChartView setData:[_lineChartView generateLineChartData:xVals wearinessEntries:yVals1 painEntries:yVals2 painScoreEntries:yVals3]];
    [_lineChartView setVisibleXRangeWithMinXRange:kMaximumVisibleEntries maxXRange:kMaximumVisibleEntries * 2];
    [_lineChartView zoom:(max / kMaximumVisibleEntries) scaleY:1 x:0 y:0];
    
    [self showBarChart];
    
    [_barChartView moveViewToX:_barChartView.chartXMax];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)switchFromChart:(BarLineChartViewBase *)fromChart toChart:(BarLineChartViewBase *)toChart
{
    if (!_isSwitching && fromChart.hidden == NO) {
        _isSwitching = YES;
        fromChart.hidden = YES;
        toChart.hidden = NO;
        return YES;
    }
    return NO;
}

- (void)showBarChart
{
    if ([self switchFromChart:_lineChartView toChart:_barChartView]) {
        [_barChartView moveViewToX:([_barChartView barUnitValue] * _lineChartView.lowestVisibleXIndex)];
        [_barChartView animateWithYAxisDuration:0.5f];
        _isSwitching = NO;
    }
}

- (void)showLineChart
{
    if ([self switchFromChart:_barChartView toChart:_lineChartView]) {
        [_lineChartView moveViewToX:_barChartView.lowestVisibleXIndex];
        [_lineChartView animateWithXAxisDuration:1.f];
        _isSwitching = NO;
    }
}

#pragma mark - ChartViewDelegate

- (void)chartMinScaled:(ChartViewBase *)chartView gestureAxis:(enum GestureScaleAxis)gestureAxis
{
    if (gestureAxis == GestureScaleAxisX) {
        [self showBarChart];
    }
}

- (void)chartMaxScaled:(ChartViewBase *)chartView gestureAxis:(enum GestureScaleAxis)gestureAxis
{
    if (gestureAxis == GestureScaleAxisX) {
        [self showLineChart];
    }
}

@end
