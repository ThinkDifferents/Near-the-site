//
//  ViewController.m
//  高德地理定位
//
//  Created by shiwei on 17/8/3.
//  Copyright © 2017年 ThinkDifferent. All rights reserved.
//

#import "ViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface ViewController ()<AMapSearchDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic,strong) AMapSearchAPI  *search;

@property (nonatomic, strong) NSMutableArray *addressArray;

@end

@implementation ViewController

- (NSMutableArray *)addressArray
{
    if (_addressArray == nil) {
        _addressArray = [[NSMutableArray alloc]init];
    }
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =2;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 2;
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:false completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        AMapPOI *first  = [[AMapPOI alloc] init];
        first.name      = @"不显示位置";
        [self.addressArray addObject:first];
        
        NSLog(@"addressArray - %@", self.addressArray);
        //        if (self.oldPoi) {
        //            AMapPOI *poi                = self.oldPoi;
        //            self.needInsertOldAddress   = poi.address.length > 0;
        //            self.isSelectCity           = poi.address.length == 0;
        //        }
        
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location                    = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        request.keywords                    = @"";
        request.sortrule                    = 0;
        request.requireExtension            = YES;
        request.radius                      = 1000;
        request.page                        = 0;
        request.offset                      = 20;
        request.types                       = @"050000|060000|070000|080000|090000|100000|110000|120000|130000|140000|150000|160000|170000";
        
        [self.search AMapPOIAroundSearch:request];
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
    
}

- (AMapSearchAPI *)search{
    if (!_search) {
        _search = ({
            AMapSearchAPI *api = [[AMapSearchAPI alloc] init];
            api.delegate       = self;
            api;
        });
    }
    return _search;
}

#pragma mark - AMapSearchDelegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
    if (response.pois.count == 0){
        return;
    }
    
    if (self.addressArray.count == 1) {
        AMapPOI *poi = [[AMapPOI alloc] init];
        poi.city     = ((AMapPOI *)response.pois.firstObject).city;
        [self.addressArray addObject:poi];
    }
    
    [self.addressArray addObjectsFromArray:response.pois];
    
    for (AMapPOI *poi in self.addressArray) {
        NSLog(@"name - %@", poi.name);
        NSLog(@"address - %@", poi.address);
    }
    
}


@end
