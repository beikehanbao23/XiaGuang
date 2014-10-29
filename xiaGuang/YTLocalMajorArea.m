//
//  YTLocalMajorArea.m
//  HighGuang
//
//  Created by Yuan Tao on 9/2/14.
//  Copyright (c) 2014 Yuan Tao. All rights reserved.
//

#import "YTLocalMajorArea.h"

@implementation YTLocalMajorArea{
    NSString *_tmpMapName;
    NSString *_tmpMajorAreaId;
    NSString *_tmpFloorId;
    NSString *_tmpName;
    NSMutableArray *_tmpMinorAreas;
    
    NSMutableArray *_tmpMerchantAreas;
    NSMutableArray *_tmpElevators;
    NSMutableArray *_tmpBathrooms;
    
    id<YTFloor> _tmpFloor;
}

@synthesize mapName;
@synthesize merchantLocations;
@synthesize minorAreas;
@synthesize elevators;
@synthesize identifier;
@synthesize floor;
@synthesize bathrooms;

-(id)initWithDBResultSet:(FMResultSet *)findResultSet{
    if(findResultSet != nil){
        self = [super init];
        if(self){
            _tmpMapName = [findResultSet stringForColumn:@"mapName"];
            _tmpMajorAreaId = [findResultSet stringForColumn:@"majorAreaId"];
            _tmpFloorId = [findResultSet stringForColumn:@"floorId"];
            _tmpName = [findResultSet stringForColumn:@"majorAreaName"];
            
        }
    }
    return self;
    
}

-(NSString *)mapName{
    return _tmpMapName;
}

-(NSArray *)elevators{
    if(_tmpElevators == nil){
        
        FMDatabase *db = [YTDBManager sharedManager];
        FMResultSet *resultSet = [db executeQuery:@"select * from Elevator where majorAreaId = ?",_tmpMajorAreaId];
        
        _tmpElevators = [[NSMutableArray alloc] init];
        
        while ([resultSet next]) {
            YTLocalElevator *tmp = [[YTLocalElevator alloc] initWithDBResultSet:resultSet];
            [_tmpElevators addObject:tmp];
        }
        
    }
    
    return _tmpElevators;
}

-(NSArray *)bathrooms{
    if(_tmpBathrooms == nil){
        
        FMDatabase *db = [YTDBManager sharedManager];
        FMResultSet *resultSet = [db executeQuery:@"select * from Bathroom where majorAreaId = ?",_tmpMajorAreaId];
        
        _tmpBathrooms = [[NSMutableArray alloc] init];
        
        while ([resultSet next]) {
            YTLocalBathroom *tmp = [[YTLocalBathroom alloc] initWithDBResultSet:resultSet];
            [_tmpBathrooms addObject:tmp];
        }
        
    }
    
    return _tmpBathrooms;
}

-(NSArray *)merchantLocations{
    
    if(_tmpMerchantAreas == nil){
        
        FMDatabase *db = [YTDBManager sharedManager];
        FMResultSet *resultSet = [db executeQuery:@"select * from MerchantInstance where majorAreaId = ?",_tmpMajorAreaId];
        
        _tmpMerchantAreas = [[NSMutableArray alloc] init];
        
        while ([resultSet next]) {
            YTLocalMerchantInstance *tmp = [[YTLocalMerchantInstance alloc] initWithDBResultSet:resultSet];
            [_tmpMerchantAreas addObject:tmp];
        }
        
    }
    
    return _tmpMerchantAreas;
}

-(NSArray *)minorAreas{
    if(_tmpMinorAreas == nil){
        
        FMDatabase *db = [YTDBManager sharedManager];
        FMResultSet *resultSet = [db executeQuery:@"select * from MinorArea where majorAreaId = ?",_tmpMajorAreaId];
        
        _tmpMinorAreas = [[NSMutableArray alloc] init];
        
        while ([resultSet next]) {
            YTLocalMinorArea *tmp = [[YTLocalMinorArea alloc] initWithDBResultSet:resultSet];
            [_tmpMinorAreas addObject:tmp];
        }
        
    }
    
    return _tmpMinorAreas;
}

-(NSString *)identifier{
    return _tmpMajorAreaId;
}

-(id<YTFloor>)floor{
    if(_tmpFloor == nil){
        
        FMDatabase *db = [YTDBManager sharedManager];
        if([db open]){
            
            FMResultSet *result = [db executeQuery:@"select * from Floor where floorId = ?",_tmpFloorId];
            [result next];
            
            _tmpFloor = [[YTLocalFloor alloc] initWithDBResultSet:result];
        }
    }
    return _tmpFloor;
}






@end
