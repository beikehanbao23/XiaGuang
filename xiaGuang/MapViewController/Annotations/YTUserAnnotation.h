//
//  YTUserAnnotation.h
//  HighGuang
//
//  Created by Yuan Tao on 10/20/14.
//  Copyright (c) 2014 Yuan Tao. All rights reserved.
//

#import "YTAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "RMMarker+RMMarker_YTExtension.h"
@interface YTUserAnnotation : YTAnnotation

-(id)initWithMapView:(RMMapView *)aMapView
 andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
