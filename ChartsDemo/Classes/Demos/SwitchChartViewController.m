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

@property (nonatomic, strong) IBOutlet BarChartView *chartView;

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
    
    _chartView.delegate = self;
    
    _chartView.descriptionText = @"";
    _chartView.noDataTextDescription = @"You need to provide data for the chart.";
    
    _chartView.pinchZoomEnabled = NO;
    _chartView.scaleYEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    
    BalloonMarker *marker = [[BalloonMarker alloc] initWithColor:[UIColor colorWithWhite:180/255. alpha:1.0] font:[UIFont systemFontOfSize:12.0] insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
    
    ChartLegend *legend = _chartView.legend;
    legend.position = ChartLegendPositionRightOfChartInside;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    leftAxis.valueFormatter = [[NSNumberFormatter alloc] init];
    leftAxis.valueFormatter.maximumFractionDigits = 1;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.spaceTop = 0.25;
    
    _chartView.rightAxis.enabled = NO;
    
    [self setDataCount:30 range:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        [xVals addObject:[@(i + 1990) stringValue]];
    }
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    double mult = range * 1000.f;
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals1 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals2 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
        
        val = (double) (arc4random_uniform(mult) + 3.0);
        [yVals3 addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:i]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithYVals:yVals1 label:@"Company A"];
    [set1 setColor:[UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f]];
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithYVals:yVals2 label:@"Company B"];
    [set2 setColor:[UIColor colorWithRed:164/255.f green:228/255.f blue:251/255.f alpha:1.f]];
    BarChartDataSet *set3 = [[BarChartDataSet alloc] initWithYVals:yVals3 label:@"Company C"];
    [set3 setColor:[UIColor colorWithRed:242/255.f green:247/255.f blue:158/255.f alpha:1.f]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BarChartData *data = [[BarChartData alloc] initWithXVals:xVals dataSets:dataSets];
    data.groupSpace = 0.8;
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
    
    _chartView.data = data;
    [_chartView setVisibleXRangeWithMinXRange:7 maxXRange:15];
}

- (void)optionTapped:(NSString *)key
{
    [super handleOption:key forChartView:_chartView];
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
